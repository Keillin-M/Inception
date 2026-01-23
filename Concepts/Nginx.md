## 🔀 Nginx ↔ PHP-FPM ↔ MariaDB Flow

This is **critical**. Let’s slow down.

---

**Nginx** (pronounced “engine-x”) is a fast, lightweight web server and reverse proxy that’s used to serve websites and handle traffic.

Think of it like a super-efficient traffic cop for the web 🚦

What Nginx does

- Serves web pages (HTML, CSS, images, etc.)
- Reverse proxy: sits in front of other servers (like Node.js, Python, PHP apps) and forwards requests to them
- Load balancing: spreads traffic across multiple servers so nothing gets overwhelmed
- Handles tons of connections at once with very low memory usage
- SSL/TLS termination (HTTPS)

Why people love it

- ⚡ Very fast (especially for static files)
- 🧠 Event-driven architecture → great for high traffic
- 💸 Efficient: uses less RAM than older servers like Apache
- 🧩 Plays nicely with modern stacks (Docker, Kubernetes, microservices)

---

**PHP-FPM** = **PHP FastCGI Process Manager**.

In plain terms: it’s the thing that **actually runs your PHP code** when you use Nginx.

### Why PHP-FPM exists

Nginx **cannot execute PHP by itself**. So the usual setup is:

```
Browser → Nginx → PHP-FPM → PHP app
```

* **Nginx** handles HTTP, static files, SSL, routing
* **PHP-FPM** runs the PHP scripts and sends the result back to Nginx

### What PHP-FPM does

* Manages **pools of PHP worker processes**
* Executes `.php` files
* Handles many requests efficiently
* Lets you fine-tune performance (memory, workers, timeouts)

---

**MariaDB** is a **relational database**—basically where your app stores its data (users, posts, orders, etc.).

It’s a **drop-in replacement for MySQL**, and in many setups it *is* MySQL in spirit.

### What MariaDB is

* An **open-source SQL database**
* Forked from MySQL (created by the original MySQL developers)
* Uses **SQL** (`SELECT`, `INSERT`, `JOIN`, etc.)
* Stores data in tables with rows + columns

### Why people choose MariaDB

* 🆓 Fully open source (no Oracle control)
* ⚡ Very fast and well-optimized
* 🔁 Compatible with MySQL tools, drivers, and syntax
* 🧠 Extra features + performance improvements

### Where it fits in a web stack

In your classic setup:

```
Browser
  ↓
Nginx
  ↓
PHP-FPM
  ↓
MariaDB
```

* PHP talks to MariaDB using drivers like `mysqli` or `PDO`
* MariaDB stores and retrieves the data
* Results flow back up to the browser

### MariaDB vs MySQL (quick)

* **MariaDB**: community-driven, more open, often faster
* **MySQL**: owned by Oracle, still popular, sometimes more conservative

For most apps (WordPress, Laravel, Joomla):
👉 **You can swap MySQL ↔ MariaDB without changing code**

### Common use cases

* WordPress sites
* E-commerce stores
* APIs
* Any PHP app needing structured data

---

### Step-by-step Request Flow

#### 🌐 Browser → Nginx

* User visits `example.com`
* Nginx receives HTTP request

Nginx:

* Serves static files (CSS, images)
* For PHP files → passes request forward

---

#### Nginx → PHP-FPM

* PHP-FPM executes PHP code
* WordPress logic runs here
* Needs database access

---

#### PHP-FPM → MariaDB

* Queries:

  * Posts
  * Users
  * Settings
* MariaDB responds with data

#### Backward Flow

```
MariaDB → PHP-FPM → Nginx → Browser
```

📦 Think:

> “Nginx = receptionist
> PHP-FPM = worker
> MariaDB = filing cabinet”

