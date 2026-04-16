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

Pour le modifier :

```bash
# Devenir root d'abord, puis lancer changepassword en interactif
sudo su
cd /var/www/yamtrack/src
sudo -u yamtrack /var/www/yamtrack/venv/bin/python manage.py changepassword <nom_utilisateur>
```

## Variables d'environnement personnalisées

Yamtrack prend en charge des variables d'environnement optionnelles pour configurer les intégrations externes (Trakt, Simkl, AniList, Steam, etc.). Voir la [documentation upstream](https://github.com/FuzzyGrim/Yamtrack/wiki/Media-Import-Configuration) pour la liste complète (par ex. `TRAKT_API`, `TRAKT_API_SECRET`, `SIMKL_ID`, `SIMKL_SECRET`, `ANILIST_ID`, `ANILIST_SECRET`, `STEAM_API_KEY`).

Pour ajouter des variables personnalisées, éditez `/var/www/yamtrack/.env` en tant que root :

```bash
sudo nano /var/www/yamtrack/.env
```

Ajoutez vos variables à la fin du fichier, puis redémarrez les services :

```bash
sudo systemctl restart yamtrack yamtrack-celery yamtrack-celery-beat
```

Ces variables personnalisées sont **conservées lors des mises à jour**. Les variables gérées par le paquet (base de données, SSO, etc.) sont toujours régénérées à partir des paramètres YunoHost et ne doivent pas être modifiées manuellement.
