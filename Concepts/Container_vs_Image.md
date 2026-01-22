## 📦 Container vs 🧱 Image

### Docker Image

An **image is a blueprint**.

* Read-only
* Defines:

  * OS base (e.g., Alpine Linux)
  * Installed software (nginx, php, mariadb)
  * Configuration
* Does **nothing by itself**

📦 Think:

> “An image is a recipe”

---

### Docker Container

A **container is a running instance** of an image.

* Created from an image
* Has:

  * Running process
  * Temporary writable layer
* Can be started, stopped, deleted

📦 Think:

> “A container is a cooked meal from the recipe”

---

### 🔑 Relationship

```
Image → Container
Blueprint → Running app
```
