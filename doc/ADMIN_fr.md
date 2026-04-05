## Activer ou désactiver le SSO

Vous pouvez modifier le paramètre SSO à tout moment :

```bash
# Activer le SSO
sudo yunohost app setting yamtrack enable_sso -v 1
sudo yunohost app upgrade yamtrack

# Désactiver le SSO
sudo yunohost app setting yamtrack enable_sso -v 0
sudo yunohost app upgrade yamtrack
```

## Compte administrateur

Lors de l'installation, un compte administrateur est créé avec le nom d'utilisateur YunoHost et un mot de passe aléatoire. Vous pouvez récupérer ce mot de passe avec :

```bash
sudo yunohost app setting yamtrack admin_password
```

Pour le modifier (nécessite root) :

```bash
sudo -u yamtrack bash -c "cd /var/www/yamtrack/src && /var/www/yamtrack/venv/bin/python manage.py changepassword <nom_utilisateur>"
```
