# User Documentation

## 📌 Overview

This project provides a containerized web infrastructure including:
- A WordPress website
- A MariaDB database
- An NGINX web server

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

Credentials are stored in:

* `.env` file
* Docker secrets 

Example:

* Database user
* Database password
* WordPress admin credentials

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

## 🛠️ Troubleshooting

* Make sure Docker is running
* Rebuild containers:

```bash
make re
```

* Check logs for errors

````

---