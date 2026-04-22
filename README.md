# 🐳 Inception — Docker Infrastructure

Building a secure, modular, and reproducible system using Docker and Docker Compose.

Welcome to **Inception**, a system administration project from the 42 curriculum. This project introduces **containerization**, **service orchestration**, and **infrastructure design** using Docker.

The goal is to set up a small infrastructure composed of multiple services, each running in its own container, all managed through Docker Compose.

---

## 🚀 Project Overview

Inception focuses on:

* Understanding containerization with Docker
* Creating and managing multiple services
* Building custom Docker images
* Orchestrating containers with Docker Compose
* Ensuring secure and isolated environments
* Configuring networking and volumes

I built a fully functional web infrastructure from scratch, emphasizing **reproducibility**, **security**, and **best practices**.

---

## 🧱 Architecture

The infrastructure includes:

* **NGINX** — Web server with TLS (HTTPS)
* **WordPress** — CMS powered by PHP-FPM
* **MariaDB** — Database server

Each service:

* Runs in its own container
* Uses a dedicated Docker image
* Communicates through a Docker network
* Persists data using volumes

---

## 🔧 Services Overview

### 🌐 NGINX

* Acts as the entry point to the infrastructure
* Handles HTTPS connections
* Proxies requests to WordPress

---

### 📝 WordPress (PHP-FPM)

* Runs WordPress with PHP-FPM
* Connects to MariaDB for data storage
* No web server inside the container (handled by NGINX)

---

### 🗄️ MariaDB

* Stores WordPress data
* Configured with secure credentials
* Uses persistent volumes to retain data

---

## 🧠 Key Concepts Covered

* Docker basics:

  * Images
  * Containers
  * Volumes
  * Networks
* Docker Compose orchestration
* Writing Dockerfiles
* Environment variables and secrets
* TLS/SSL configuration
* Service dependency management
* System security and isolation

---

## 🛠️ Technologies

* **Containerization:** Docker
* **Orchestration:** Docker Compose
* **Web Server:** NGINX
* **Database:** MariaDB
* **CMS:** WordPress
* **OS:** Linux

---

## 📦 How to Use

Clone the repository:

```bash
git clone https://github.com/Keillin-M/inception.git
cd inception
```

Build and start the infrastructure:

```bash
make
```

Stop the services:

```bash
make fclean
```

---

## 🔒 Security Considerations

* Use environment variables for sensitive data
* Avoid hardcoding credentials
* Enable HTTPS with TLS certificates
* Restrict container privileges
* Use `.env` files and Docker secrets when possible

---

## 🧪 Challenges Faced

* Configuring multiple containers to communicate correctly
* Setting up TLS and HTTPS properly
* Managing persistent data with volumes
* Debugging container networking issues
* Writing efficient and minimal Dockerfiles
* Ensuring services restart and remain stable

---

## 💡 Lessons Learned

* Containerization simplifies deployment and reproducibility
* Proper isolation improves system security
* Networking is crucial in multi-service architectures
* Docker Compose makes complex setups manageable
* Debugging containers requires a different mindset than traditional systems
* Clean configuration leads to scalable infrastructure

---
