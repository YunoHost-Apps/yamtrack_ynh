#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

timezone=$(timedatectl show --value --property=Timezone)

# Write the .env config file and append OIDC + BASE_URL settings
# This avoids issues with ynh_config_add sed substitution on JSON values
yamtrack_setup_env() {
    # Deploy the base .env template
    ynh_config_add --template=".env" --destination="$install_dir/.env"

    # Handle BASE_URL: empty if root path, otherwise the subpath
    local base_url=""
    if [[ "$path" != "/" ]]; then
        base_url="$path"
    fi
    echo "BASE_URL=$base_url" >> "$install_dir/.env"

    # Append OIDC/SSO settings (values from app settings, written directly to avoid sed issues with JSON)
    echo "SOCIAL_PROVIDERS=$social_providers" >> "$install_dir/.env"
    echo "SOCIALACCOUNT_PROVIDERS=$socialaccount_providers" >> "$install_dir/.env"
    echo "SOCIALACCOUNT_ONLY=$socialaccount_only" >> "$install_dir/.env"
    echo "REDIRECT_LOGIN_TO_SSO=$redirect_login_to_sso" >> "$install_dir/.env"

    chmod 400 "$install_dir/.env"
    chown "$app:$app" "$install_dir/.env"
}

# Register Yamtrack as an OIDC client in Dex (if installed)
yamtrack_register_dex() {
    local dex_domain
    local dex_path
    local dex_install_dir

    dex_domain=$(yunohost app setting dex domain 2>/dev/null)
    dex_path=$(yunohost app setting dex path 2>/dev/null)
    dex_install_dir=$(yunohost app setting dex install_dir 2>/dev/null)

    if [[ -z "$dex_domain" ]]; then
        # Dex not installed, use local auth
        social_providers=""
        socialaccount_providers="{}"
        socialaccount_only="False"
        redirect_login_to_sso="False"
    else
        # Generate OIDC secret if not already set
        if [[ -z "${oidc_secret:-}" ]]; then
            oidc_secret=$(ynh_string_random --length=32)
        fi

        # Register as OIDC client in Dex
        local oidc_callback="${domain}${path}/accounts/oidc/yunohost/login/callback/"
        if [[ -n "$dex_install_dir" ]] && [[ -f "$dex_install_dir/add_config.sh" ]]; then
            bash "$dex_install_dir/add_config.sh" "$app" "$app" "$oidc_callback" "$oidc_secret"
            ynh_systemctl --service="dex" --action="restart" 2>/dev/null || true
        fi

        social_providers="allauth.socialaccount.providers.openid_connect"
        socialaccount_providers="{\"openid_connect\":{\"APPS\":[{\"provider_id\":\"yunohost\",\"name\":\"YunoHost\",\"client_id\":\"${app}\",\"secret\":\"${oidc_secret}\",\"settings\":{\"server_url\":\"https://${dex_domain}${dex_path}\"}}]}}"
        socialaccount_only="True"
        redirect_login_to_sso="True"
    fi

    # Save settings
    ynh_app_setting_set --key=oidc_secret --value="${oidc_secret:-}"
    ynh_app_setting_set --key=dex_domain --value="${dex_domain:-}"
    ynh_app_setting_set --key=dex_path --value="${dex_path:-}"
    ynh_app_setting_set --key=social_providers --value="$social_providers"
    ynh_app_setting_set --key=socialaccount_providers --value="$socialaccount_providers"
    ynh_app_setting_set --key=socialaccount_only --value="$socialaccount_only"
    ynh_app_setting_set --key=redirect_login_to_sso --value="$redirect_login_to_sso"
}
