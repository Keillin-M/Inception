# Developer Documentation

## 📌 Environment Setup

### Requirements

- Docker
- Docker Compose
- Make

---

## ⚙️ Configuration

Before running the project:

1. Create a `.env` file
2. Configure environment variables:
   - Domain name
   - Database credentials
   - WordPress credentials

3. Set up secrets if required

---

## 🚀 Build & Run

Build and start:

```bash
make up
````

Rebuild:

```bash
make re
```

Stop:

```bash
make down
```

---

## 🐳 Docker Commands

List containers:

```bash
docker ps
```

Access a container:

```bash
docker exec -it <container_name> bash
```

View logs:

```bash
docker logs <container_name>
```

---

## 💾 Data Persistence

Data is stored in Docker volumes:

* WordPress files
* MariaDB database

Volumes ensure data is not lost when containers stop.

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
