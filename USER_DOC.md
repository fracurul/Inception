# **USER\_DOC — User & Administrator Documentation**

*Inception project — fracurul.42.fr*

---

## SERVICES PROVIDED

The stack provides a fully functional WordPress website accessible via HTTPS. It consists of three services running together:

| Service | What it does |
|---------|-------------|
| **Nginx** | Serves the website securely over HTTPS. |
| **WordPress** | The website and content management system (CMS). |
| **MariaDB** | The database that stores all site content and users. |

As an administrator, you only interact with WordPress — the rest runs in the background automatically.

---

## START AND STOP THE PROJECT

Open a terminal in the project root directory.

**Start the project:**
```bash
make build
```

**Stop the project:**
```bash
make down
```

> ⚠️ `make down` stops the containers but does **not** delete any data. Your site content is safe.

---

## ACCESS THE WEBSITE

Once the project is running, open your browser and visit:

```
https://fracurul.42.fr
```

> Your browser may show a security warning because the site uses a self-signed certificate. This is expected — click "Advanced" and proceed to the site.

---

## ACCESS THE ADMINISTRATION PANEL

To manage the site (posts, pages, users, settings), go to:

```
https://fracurul.42.fr/wp-admin
```

Log in with the admin credentials from your `.env` file:

| Field | Variable |
|-------|----------|
| Username | `WP_ADMIN` |
| Password | `WP_ADMIN_PASS` |

---

## CREDENTIALS

All credentials are stored in the `.env` file at `/home/fracurul/.env` on the host machine.

| Variable | Description |
|----------|-------------|
| `WP_ADMIN` | WordPress administrator username |
| `WP_ADMIN_PASS` | WordPress administrator password |
| `WP_USER` | WordPress editor username |
| `WP_USER_PASS` | WordPress editor password |
| `DB_NAME` | Database name |
| `DB_USER` | Database user |
| `DB_USER_PASS` | Database user password |
| `DB_ROOT_PASS` | Database root password |

> ⚠️ Never share or commit this file.

---

## CHECK THAT EVERYTHING IS WORKING

1. Open `https://fracurul.42.fr` in your browser — the WordPress site should load.
2. Open `https://fracurul.42.fr/wp-admin` — you should be able to log in.
3. If the site does not load, make sure the project is running with `make build`.