## 🔀 Nginx ↔ PHP-FPM ↔ MariaDB Flow

This is **critical**. Let’s slow down.

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

#### 4️⃣ Backward Flow

```
MariaDB → PHP-FPM → Nginx → Browser
```

📦 Think:

> “Nginx = receptionist
> PHP-FPM = worker
> MariaDB = filing cabinet”

