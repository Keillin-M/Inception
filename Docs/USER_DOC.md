# User Documentation

## 📌 Overview

- **NGINX**: The web server and entry point (handles HTTPS/TLS).
- **WordPress**: The website content management system.
- **MariaDB**: The database storing all site data.

---

## ▶️ Starting the Project

Run:

```bash
make up
```

---

## ⏹️ Stopping the Project

```bash
make down
```

---

## 🌐 Accessing the Website

Open your browser and go to:

```
https://kmaeda.42.fr
```

---

## 🔑 Accessing the Admin Panel

WordPress admin panel:

```
https://kmaeda.42.fr/wp-admin
```

---

## 🔐 Credentials

Credentials and configuration are managed using a combination of environment variables and Docker secrets.

### 📄 Configuration (`srcs/.env`)
Contains non-sensitive environment variables:
* **Database**: `MYSQL_USER`, `MYSQL_DATABASE`, `MYSQL_PORT`
* **WordPress**: `WP_SUPERUSER_USER`, `WP_USER`, `DOMAIN_NAME`

### 🔑 Secrets (`secrets/`)
Sensitive passwords are stored in the `secrets/` directory:
* `db_root_password.txt`: MariaDB root password
* `db_password.txt`: MariaDB user password
* `wp_superuser_password.txt`: WordPress admin password
* `wp_user_password.txt`: Regular WordPress user password

### 🛠️ Setup Instructions

Before running `make`, you must manually create the `secrets` directory and its content:

1. **Create the directory:**
   ```bash
   mkdir -p secrets
   ```

2. **Generate the password files:**
   ```bash
   echo "my_root_password" > secrets/db_root_password.txt
   echo "my_db_password" > secrets/db_password.txt
   echo "my_admin_password" > secrets/wp_superuser_password.txt
   echo "my_user_password" > secrets/wp_user_password.txt
   ```

3. **Configure the `.env` file:**
   Ensure `srcs/.env` exists and contains the necessary usernames and database configuration.

---

## 🛠️ Makefile Commands

| Command | Description |
| :--- | :--- |
| `make all` | Builds and starts the entire infrastructure (default). |
| `make build` | Builds the Docker images. |
| `make up` | Starts the containers in the background. |
| `make down` | Stops and removes the containers. |
| `make re` | Full restart: stops, removes, and starts everything again. |
| `make restart` | Quickly restarts running containers. |
| `make db` | Connects to the MariaDB container shell. |
| `make logs` | Follows the logs of all services. |
| `make clean` | Removes containers and images. |
| `make fclean` | Deep clean: removes containers, images, volumes, and local data. |
| `make help` | Shows available commands. |

---

## 🧪 Checking Services

Check running containers:

```bash
docker ps
```

Check logs:

```bash
docker logs <container_name>
```

Check volumes:

```bash
docker volume ls
```

Check Port 80:

```bash
curl -k http://kmaeda.42.fr:80
```

Connect to Database:

```bash
make db
```

Check TLS (Transport Layer Security):

```bash
curl -v https://kmaeda.42.fr
```

---

## 🛠️ Troubleshooting

* Make sure Docker is running
* Rebuild containers:

```bash
make re
```

* Check logs for errors
```bash
make logs
```

---