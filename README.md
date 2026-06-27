# n8n on Render (Docker)

n8n workflow automation deployed on Render using the official n8n Docker image.

## Setup

### 1. Create PostgreSQL database (free)

1. In Render dashboard, go to **New > PostgreSQL**
2. Name: `n8n-postgres`
3. Leave **Database** and **User** blank (auto-generated)
4. Region: **Singapore** (same as your Web Service)
5. Plan: **Free**
6. Click **Create Database**
7. After creation, copy the **Internal Database URL**

### 2. Add environment variables

In your n8n Web Service dashboard, go to **Environment** and add:

| Variable | Value |
|---|---|
| `DB_TYPE` | `postgresdb` |
| `DB_POSTGRESDB_DATABASE` | *(from Postgres)* |
| `DB_POSTGRESDB_HOST` | *(from Postgres)* |
| `DB_POSTGRESDB_PORT` | `5432` |
| `DB_POSTGRESDB_USER` | *(from Postgres)* |
| `DB_POSTGRESDB_PASSWORD` | *(from Postgres)* |
| `DB_POSTGRESDB_SCHEMA` | `public` |
| `DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED` | `false` |

Existing env vars to keep:
| Variable | Value |
|---|---|
| `N8N_LISTEN_ADDRESS` | `0.0.0.0` |
| `N8N_PROTOCOL` | `https` |
| `N8N_HOST` | `yourrepo.onrender.com` </br>#Without `https` `receive after deployment` |
| `N8N_ENCRYPTION_KEY` | `9d00a75e699d6aee1aaff19a1389d65c` |
| `WEBHOOK_URL` | `https://yourrepo.onrender.com` </br>#Your render url with `https` `receive after first deploy` |
| `TZ` | `Asia/Dhaka` |
| `N8N_RUNNERS_ENABLED` | `false` |
| `N8N_DISABLE_POSTHOG` | `true` |

**DO NOT set `N8N_PORT`** — n8n uses port 5678 (already EXPOSEd in Dockerfile).

### 3. Switch Render to Docker runtime

1. Go to your n8n Web Service in Render dashboard
2. Go to **Settings**
3. Under **Runtime**, select **Docker**
4. Click **Save**

### 4. Deploy

1. Go to your n8n Web Service
2. **Manual Deploy > Clear build cache & deploy**

## Updating

Update the version tag in `Dockerfile` and push to GitHub. Render auto-deploys.
