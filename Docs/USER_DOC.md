# User Documentation

## 📌 Overview

This project provides a containerized web infrastructure including:
- A WordPress website
- A MariaDB database
- An NGINX web server

---

## 🔐 Credentials

Should not be in the repository, must be created before running.
Credentials are stored in:

* `.env` file

Example:

* Database user
* WordPress admin credentials

---

## 🔐 Passwords

Should not be in the repository, must be created before running.
Passwords are stored in:
* /secrets/

Example:
* db_password.txt
* user_password.txt

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

## 🧪 Checking Services

Check running containers:

```bash
docker ps
```

Check logs:

```bash
docker logs <container_name>
```

---
