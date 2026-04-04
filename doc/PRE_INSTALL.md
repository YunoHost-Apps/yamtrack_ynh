## SSO Integration (Single Sign-On)

For seamless SSO integration with YunoHost, **install [Dex](https://apps.yunohost.org/app/dex) before installing Yamtrack**.

Dex acts as an OIDC (OpenID Connect) provider backed by your YunoHost LDAP. When Dex is detected during Yamtrack installation, SSO is automatically configured: your YunoHost users can log in to Yamtrack without creating a separate account.

If Dex is not installed, Yamtrack will work with its own local authentication system (username/password).

### Installing Dex after Yamtrack

If you install Dex after Yamtrack, you can activate SSO by running:

```bash
sudo yunohost app upgrade yamtrack
```

The upgrade script will detect Dex and configure the OIDC integration automatically.
