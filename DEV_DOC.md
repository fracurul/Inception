# **DEV\_DOC — Developer Documentation**

*Inception project — fracurul.42.fr*

---

## PREREQUISITES

| Tool | Minimum version | Check |
|------|----------------|-------|
| Docker | 20.10+ | `docker --version` |
| Docker Compose | 2.0+ (or 1.29+ legacy) | `docker compose version` |
| Make | 4.0+ | `make --version` |
| OpenSSL | Any recent | `openssl version` |

> Developed and tested on **Debian 11**. Paths like `/home/fracurul/data/` are user-specific — adjust them if running on a different account or machine.

---

## ENVIRONMENT SETUP

### 1. Clone the repository

```bash
git clone <repo-url> inception && cd inception
```

### 2. Configure the .env file

```bash
cp srcs/.env.example srcs/.env
```

Edit `srcs/.env`:

```env
DB_NAME=          # database name
DB_USER=          # database user name
DB_USER_PASS=     # database user password
DB_ROOT_PASS=     # database root password
DOMAIN_NAME=      # fracurul.42.fr
WP_USER=          # wordpress editor username
WP_USER_PASS=     # wordpress editor password
WP_ADMIN=         # wordpress admin username
WP_ADMIN_PASS=    # wordpress admin password
```

The Makefile copies `srcs/.env` to `/home/fracurul/.env` automatically. Each service reads it via `env_file: .env` in `docker-compose.yml`.

### 3. TLS Certificate

Nginx expects a self-signed certificate at:
```
/etc/nginx/ssl/fracurul.42.fr.crt
/etc/nginx/ssl/fracurul.42.fr.key
```
These are generated inside the Nginx image during the build — no manual action needed.

---

## BUILD AND LAUNCH

| Command | What it does |
|---------|-------------|
| `make build` | Creates data directories + builds images + starts containers |
| `make down` | Stops and removes containers (data is kept) |
| `make re` | Full rebuild (`fclean` + `build`) |
| `make fclean` | Removes containers, volumes, and `/home/fracurul/data/` ⚠️ |

---

## CONTAINER MANAGEMENT

**List running containers:**
```bash
docker ps
```
Expected: `nginx`, `wp_php`, `mariadb`.

**Open a shell inside a container:**
```bash
docker exec -it nginx bash
docker exec -it wp_php bash
docker exec -it mariadb bash
```

**View logs:**
```bash
docker logs nginx
docker logs wp_php
docker logs mariadb
```

**Follow logs in real time:**
```bash
docker logs -f wp_php
```

**Restart a single service:**
```bash
docker restart nginx
```

**Inspect the internal network:**
```bash
docker network inspect srcs_inception_network
```

Only Nginx is exposed to the host (`443:443`). WordPress (port 9000) and MariaDB are internal only, reachable exclusively through the `inception_network` bridge network.

---

## DATA PERSISTENCE

Volumes are defined as **bind mounts** (`type: none, o: bind`) so data lives on the host filesystem:

| Volume | Host path | Container path | Service |
|--------|-----------|---------------|---------|
| `wordpress_db` | `/home/fracurul/data/mariadb` | `/var/lib/mysql` | MariaDB |
| `wordpress_files` | `/home/fracurul/data/wordpress` | `/var/www/html` | WordPress + Nginx |

Data **survives** `make down` + `make build` because the host directories are not touched.
Data is **permanently deleted** by `make fclean`.

**Inspect volumes:**
```bash
docker volume ls
docker volume inspect srcs_wordpress_db
docker volume inspect srcs_wordpress_files
```