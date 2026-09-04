# Lab Work: HAProxy + Nginx

Student: Ilembetov Vasil Razhapovich

This project contains materials and configurations for a homework assignment on load balancing using HAProxy and Nginx.

## Project Structure

```
├── haproxy-lab/           # Test Python servers
│   ├── server1/           # Server 1 (weight 2)
│   ├── server2/           # Server 2 (weight 3)
│   └── server3/           # Server 3 (weight 4)
├── scripts/               # Configuration files
│   ├── haproxy.cfg        # HAProxy configuration
│   └── Nginx              # Nginx configuration
└── img/                   # Homework screenshots
    ├── 1.png
    ├── 2.png
    └── 3.png
```

---

## Task 1: Round-Robin Load Balancing at Layer 4 (TCP)

**Goal:** Run two simple Python servers on different ports and configure HAProxy for Layer 4 (TCP) load balancing using the round-robin algorithm.

### Description

- Two Python servers are started on different ports.
- HAProxy is configured to balance TCP requests between the servers.
- The round-robin algorithm is used to evenly distribute the load.

### Verification

Send requests to HAProxy and observe alternating responses from different servers.

![Task 1 — Round-Robin TCP](img/1.png)

---

## Task 2: Weighted Round-Robin at Layer 7 (HTTP)

**Goal:** Run three Python servers and configure HAProxy for Layer 7 (HTTP) load balancing with different server weights.

### Description

- Three Python servers are started on different ports.
- HAProxy is configured to balance HTTP requests at Layer 7.
- Server weights:
  - Server 1 — weight **2**
  - Server 2 — weight **3**
  - Server 3 — weight **4**
- HAProxy accepts and forwards only traffic addressed to the domain **example.local**.

### Verification

- Requests with the `example.local` domain are correctly forwarded to backends.
- Requests without the domain are denied.

![Task 2 — Weighted Round-Robin HTTP](img/2.png)

---

## Task 3*: HAProxy + Nginx Setup

**Goal:** Configure an Nginx + HAProxy pipeline where Nginx serves static files and forwards dynamic requests to HAProxy.

### Description

- **Nginx** listens on port 80 and:
  - Serves static files (`.jpg`, `.jpeg`, `.png`) directly from `/var/www/images/`.
  - Forwards all other requests to HAProxy (`127.0.0.1:8089`).
- **HAProxy** receives requests and distributes them between two Python servers using round-robin.
- Test images are added to `/var/www/` for verifying static file serving.

### Verification

- `.jpg` requests are served directly by Nginx.
- Requests for other resources are proxied through HAProxy to Python servers.

![Task 3 — HAProxy + Nginx](img/3.png)

---

## Configuration Files

### HAProxy

Configuration file: [`scripts/haproxy.cfg`](scripts/haproxy.cfg)

Includes:
- Frontend with ACL for filtering by `example.local` domain
- Backend with Weighted Round-Robin (weights 2, 3, 4)
- Frontend for TCP balancing at Layer 4
- Frontend and backend for HTTP balancing of Python servers
- Statistics page at `http://<host>:8888/stats`

### Nginx

Configuration file: [`scripts/Nginx`](scripts/Nginx)

Includes:
- Location for serving static images (`.jpg`, `.jpeg`, `.png`) from `/var/www/images/`
- Proxied location `/` to HAProxy (`127.0.0.1:8089`)

---

## How to Run

### 1. Start Test Python Servers

```bash
# Server 1 — port 8888
python3 -m http.server 8888 --directory haproxy-lab/server1

# Server 2 — port 9999
python3 -m http.server 9999 --directory haproxy-lab/server2

# Server 3 — port 7777
python3 -m http.server 7777 --directory haproxy-lab/server3
```

### 2. Place Test Images

```bash
sudo mkdir -p /var/www/images
sudo cp img/*.jpg /var/www/images/ 2>/dev/null || true
```

### 3. Start Nginx

```bash
sudo cp scripts/Nginx /etc/nginx/sites-available/default
sudo nginx -t && sudo systemctl restart nginx
```

### 4. Start HAProxy

```bash
sudo cp scripts/haproxy.cfg /etc/haproxy/haproxy.cfg
sudo systemctl reload haproxy
```

### 5. Verification

| Task | URL / Command |
|------|---------------|
| Round-Robin TCP | `curl http://127.0.0.1:1325` |
| Weighted HTTP | `curl -H "Host: example.local" http://127.0.0.1:8088` |
| HAProxy Stats | `http://127.0.0.1:8888/stats` |
| Nginx Static | `http://127.0.0.1/image.jpg` |
| Proxy via HAProxy | `http://127.0.0.1/` |
