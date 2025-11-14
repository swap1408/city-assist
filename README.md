# 🚀 PriaccEnterprise.AI – Complete Smart City Platform Deployment Guide
This file contains **EVERYTHING we have built, configured, debugged, and deployed together** — in ONE final, clean README.

---

# 📌 1. Project Overview
PriaccEnterprise.AI is a **Smart City AI Platform** integrating:

- React + Vite PWA Frontend
- Java Spring Boot Backend
- Python FastAPI ML Microservices
- PostgreSQL
- Nginx Reverse Proxy
- Docker & Docker Compose
- Jenkins + GitHub Webhooks CI/CD
- Docker Hub Registry
- Grafana Monitoring
- ELK (Elasticsearch + Logstash + Kibana)
- Certbot SSL
- Route53 + Hostinger Domain
- AWS EC2 Servers

---

# 📌 2. Architecture Diagram

```
React → NGINX → Spring Boot API
                ↘ Python FastAPI ML
                ↘ PostgreSQL
                ↘ Grafana / ELK
                ↘ Certbot SSL
```

---

# 📌 3. Folder Structure

```
city-assist/
 ├── frontend/
 ├── backend/
 ├── python/
 ├── docker-compose.yml
 └── README.md
```

---

# 📌 4. Docker Compose Setup

Run:

```
docker-compose build --no-cache
docker-compose up -d
```

Service URLs:

- Frontend → `http://localhost:8081`
- Backend  → `http://backend:8080`
- Python   → `http://python:8000`

---

# 📌 5. NGINX Reverse Proxy

### Correct routes:

| Route | Points To |
|-------|-----------|
| `/api` | Spring Boot Backend |
| `/env.js` | Runtime environment |
| `/python-api` | Python FastAPI |

Fixes included:

- Removed `/api/api` issue
- Ensured proper proxy_pass
- Ensured env.js cache busting

---

# 📌 6. Frontend Runtime ENV Injection

File: `/frontend/docker/entrypoint.sh`

Exports:

```
VITE_API_URL=/api
CITYASSIST_API_URL=http://python:8000
```

Creates env.js dynamically **at runtime**, not build time.

---

# 📌 7. Spring Boot Security Fixes

Final working SecurityConfig allowed:

```
/api/v1/auth/login
/api/v1/auth/register
/api/v1/auth/refresh
/api/v1/seed/**
```

We fixed all **403 errors**.

---

# 📌 8. FastAPI ML Services

Working endpoints:

```
/api/routes/predict
/api/outage/predict
/api/image/predict
/api/alerts/predict
```

Verified using:

```
docker exec -it frontend curl http://python:8000/api/alerts/predict
```

---

# 📌 9. Jenkins CI/CD Pipeline

Stages included:

1. GitHub webhook trigger
2. Checkout
3. Docker build
4. Tag & push to Docker Hub
5. SSH into EC2
6. Pull & restart deployment

---

# 📌 10. Docker Registry

Images pushed as:

```
swapnilneo/hack-backend
swapnilneo/hack-frontend
swapnilneo/hack-python
```

Auto-tagged using Jenkins BUILD_NUMBER.

---

# 📌 11. DNS + SSL Setup

Hostinger Domain + Route53:

```
A Record → EC2 Public IP
```

SSL certificate:

```
sudo certbot --nginx -d yourdomain.com
```

---

# 📌 12. Monitoring With Grafana

- Node exporter enabled
- Prometheus → Grafana dashboards

---

# 📌 13. Logging Using ELK

- Logstash → Parse containers logs
- Elasticsearch → Storage
- Kibana → Visual dashboards

---

# 📌 14. Major Debug Fixes Completed

| Problem | Fixed |
|--------|--------|
| 403 on register | ✔ Spring perms updated |
| env.js not updating | ✔ entrypoint + cache bust |
| double `/api/api` | ✔ fixed Nginx + api.ts |
| Python API unreachable | ✔ CITYASSIST_API_URL injected |
| Wrong container routing | ✔ docker-compose fixed |
| Browser caching old env.js | ✔ Ctrl+Shift+R |

---

# 📌 15. Deployment Update Commands

```
docker-compose down
docker-compose pull
docker-compose up -d
```

---

# 📌 16. Author

Created & configured by **Swapnil Gaurkar**  
All deployments, debugging, architecture, and CI/CD included.

---

# ✅ END OF README
