## Integration SSO (Authentification unique)

Pour l'integration SSO avec YunoHost, **installez [Dex](https://apps.yunohost.org/app/dex) avant d'installer Yamtrack** et activez l'option "SSO via Dex" lors de l'installation.

Dex agit comme un fournisseur OIDC (OpenID Connect) base sur le LDAP de votre YunoHost. Lorsque Dex est detecte et que le SSO est active, vos utilisateurs YunoHost peuvent se connecter a Yamtrack sans creer de compte separe.

Si le SSO est desactive ou que Dex n'est pas installe, Yamtrack fonctionnera avec son propre systeme d'authentification locale (nom d'utilisateur/mot de passe).

### Activer ou desactiver le SSO plus tard

Vous pouvez modifier le parametre SSO a tout moment :

```bash
# Activer le SSO
sudo yunohost app setting yamtrack enable_sso -v 1
sudo yunohost app upgrade yamtrack

# Desactiver le SSO
sudo yunohost app setting yamtrack enable_sso -v 0
sudo yunohost app upgrade yamtrack
```
