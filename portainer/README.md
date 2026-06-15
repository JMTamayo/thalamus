## Portainer Server Configuration:

### Set the default admin password:

Portainer's admin user is always named `admin`; only its password can be
pre-configured. The password is read at first startup from a plain-text file
mounted into the container (`--admin-password-file`).

#### Create the password file:

Run the following command to create the password file:

```bash
touch portainer/config/portainer_password
```

#### Set the password:

Edit the file so it contains only the desired password (minimum 12 characters):

```bash
nano portainer/config/portainer_password
```

You can use `portainer/config/portainer_password.example` as a reference for the
expected format.

The `portainer_password` file is ignored by git and must never be committed.

At this point, Portainer is configured and ready to be deployed.

### Notes:

- The pre-configured password only applies on the **first startup**, while the
  `portainer_data` volume is empty. If Portainer has already been initialised,
  reset it so the new password takes effect:

  ```bash
  docker compose down
  docker volume rm thalamus-portainer-data
  docker compose up -d
  ```

- The password must be at least 12 characters long, otherwise Portainer will
  refuse to start.
