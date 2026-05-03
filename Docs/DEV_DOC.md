# Developer Documentation

## 📌 Environment Setup

### Requirements

- Docker
- Docker Compose
- Make

---

## ⚙️ Configuration & Secrets

Before running the project, you must set up the environment files.

### 1. Environment Variables (`srcs/.env`)
Create a `.env` file in the `srcs/` directory with the following variables:
- `DOMAIN_NAME`: e.g., `kmaeda.42.fr`
- `MYSQL_DATABASE`, `MYSQL_USER`: Database setup.
- `WP_SUPERUSER_USER`, `WP_USER`: WordPress user accounts.

### 2. Docker Secrets (`secrets/`)
Create a `secrets/` folder in the root directory and add the following plain text files:
- `db_root_password.txt`
- `db_password.txt`
- `wp_superuser_password.txt`
- `wp_user_password.txt`

> [!IMPORTANT]
> Never commit these files to version control. Ensure they are listed in your `.gitignore`.

---

## 🚀 Build & Run

Build and start:

```bash
make up
```

Rebuild:

```bash
make re
```

Stop:

```bash
make down
```

---

## 🐳 Container & Volume Management

### Container Commands
- **List running containers**: `docker ps`
- **Access a shell inside a container**: `docker exec -it <container_name> bash`
- **Follow logs**: `docker logs -f <container_name>`

### Volume Commands
- **List volumes**: `docker volume ls`
- **Inspect a volume**: `docker volume inspect <volume_name>`
- **Remove all unused volumes**: `docker volume prune`

---

## 💾 Data Persistence

The project uses host-bind volumes to ensure data persists even if containers are removed.

### Host Paths
- **WordPress Data**: `/home/${USER}/data/wordpress`
- **Database Data**: `/home/${USER}/data/mariadb`

### Persistence Logic
Volumes map these host directories to internal container paths:
* **WordPress**: Maps host folder to `/var/www/html`
* **MariaDB**: Maps host folder to `/var/lib/mysql`

This setup ensures that all site content, plugins, and database records remain intact across `make re` or system restarts.

---

## 📁 Project Structure

```
.
├── Makefile
├── docker-compose.yml
├── srcs/
│   ├── requirements/
│   │   ├── nginx/
│   │   ├── wordpress/
│   │   └── mariadb/
│   └── .env
```

---

## 🔍 Networking

* Custom Docker network connects all containers
* Services communicate using container names

---

## 🧠 Notes for Developers

* Each service has its own Dockerfile
* Avoid hardcoding credentials
* Use environment variables and secrets
* Ensure containers restart properly

```

---
