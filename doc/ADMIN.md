## Enabling or disabling SSO

You can change the SSO setting at any time:

```bash
# Enable SSO
sudo yunohost app setting yamtrack enable_sso -v 1
sudo yunohost app upgrade yamtrack

# Disable SSO
sudo yunohost app setting yamtrack enable_sso -v 0
sudo yunohost app upgrade yamtrack
```

## Admin account

During installation, an admin account is created with the YunoHost admin username and a random password. You can retrieve this password with:

```bash
sudo yunohost app setting yamtrack admin_password
```

To change it:

```bash
cd /var/www/yamtrack/src
sudo -u yamtrack /var/www/yamtrack/venv/bin/python manage.py changepassword <username>
```
