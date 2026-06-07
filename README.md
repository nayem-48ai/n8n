# n8n on Render

n8n workflow automation deployed on Render.

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
| `DATABASE_URL` | *(paste Internal Database URL from Postgres)* |

Or individually set:
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
| `N8N_PORT` | `$PORT` |
| `N8N_PROTOCOL` | `https` |
| `N8N_HOST` | `n8n-3f4f.onrender.com` |
| `N8N_ENCRYPTION_KEY` | `9d00a75e699d6aee1aaff19a1389d65c` |
| `WEBHOOK_URL` | `https://n8n-3f4f.onrender.com` |
| `TZ` | `Asia/Dhaka` |

### 3. Deploy

1. Go to your n8n Web Service
2. **Manual Deploy > Clear build cache & deploy**

## Updating

Update the `n8n` version in `package.json` and push to GitHub. Render auto-deploys.
