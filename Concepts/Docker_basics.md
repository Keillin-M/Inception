## 🐳 Dockerfile Basics

A **Dockerfile** tells Docker **how to build an image**.

It answers:

* What base OS?
* What software?
* What config?
* What command runs?

Typical logic (conceptually):

```
Start from OS
Install software
Copy config files
Define startup process
```

📦 Think:

> “Dockerfile = automated installation guide”

## 🧩 Docker Compose (Big Picture)

Docker Compose is for **multi-container applications**.

Instead of:

* Running nginx manually
* Running PHP manually
* Running database manually

You define **everything in one file**.

📦 Think:

> “docker-compose.yml = system architecture diagram in YAML”

---

## 📄 Docker Compose: Services

A **service** = one container type.

For WordPress, typical services:

* `nginx`
* `php-fpm`
* `mariadb`

Each service:

* Uses one image
* Runs one main process
* Can talk to other services

📦 Think:

> “Each service is one role in the system”

---

## 💾 Docker Compose: Volumes

Volumes handle **persistent data**.

### Why needed?

Containers are **ephemeral**:

* Delete container → data gone

### What needs persistence?

* Database files
* WordPress uploads
* WordPress config

📦 Think:

> “Volumes are external hard drives plugged into containers”

---

### Examples of persistent data

| Container       | Persistent Data |
| --------------- | --------------- |
| MariaDB         | Database files  |
| PHP / WordPress | wp-content      |
| Nginx           | (usually none)  |

---

## 🌐 Docker Compose: Networks

Networks allow containers to **talk to each other**.

* Containers communicate using **service names**
* No IP management needed
* Isolated from host unless exposed

📦 Think:

> “A private LAN just for containers”

Example:

```
nginx → php-fpm
php-fpm → mariadb
```
