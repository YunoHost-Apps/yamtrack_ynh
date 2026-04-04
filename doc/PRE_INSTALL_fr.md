## Integration SSO (Authentification unique)

Pour une integration SSO avec YunoHost, **installez [Dex](https://apps.yunohost.org/app/dex) avant d'installer Yamtrack**.

Dex agit comme un fournisseur OIDC (OpenID Connect) base sur le LDAP de votre YunoHost. Lorsque Dex est detecte pendant l'installation de Yamtrack, le SSO est automatiquement configure : vos utilisateurs YunoHost peuvent se connecter a Yamtrack sans creer de compte separe.

Si Dex n'est pas installe, Yamtrack fonctionnera avec son propre systeme d'authentification locale (nom d'utilisateur/mot de passe).

### Installer Dex apres Yamtrack

Si vous installez Dex apres Yamtrack, vous pouvez activer le SSO en lancant :

```bash
sudo yunohost app upgrade yamtrack
```

Le script de mise a jour detectera Dex et configurera l'integration OIDC automatiquement.
