## Grafana Server Configuration:

### Create the configuration files:

#### Environment file:

Run the following command to create the environment file:

```bash
touch grafana/config/.env
```

### Define the admin user and password:

Run the following command to define the admin user and password, for example, for the user "admin":

```bash
nano grafana/config/.env
```

Add the following lines to the .env file:

```
GF_SECURITY_ADMIN_USER=adminUser
GF_SECURITY_ADMIN_PASSWORD=adminPassword
```

If you want to use the default user and password, you do not need to define them in the .env file.
