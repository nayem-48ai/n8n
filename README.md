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
| `N8N_PORT` | `\$PORT` |
| `N8N_PROTOCOL` | `https` |
| `N8N_HOST` | `n8n-3f4f.onrender.com` |
| `N8N_ENCRYPTION_KEY` | `9d00a75e699d6aee1aaff19a1389d65c` |
| `WEBHOOK_URL` | `https://n8n-3f4f.onrender.com` |
| `TZ` | `Asia/Dhaka` |

### 3. New env vars (fixes crashes)

Add these to prevent the out-of-memory crashes:

| Variable | Value | Why |
|---|---|---|
| `NODE_OPTIONS` | `--max-old-space-size=384` | Prevents heap OOM on Render's 512MB free tier |
| `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS` | `true` | Fixes config permissions warning |
| `N8N_RUNNERS_ENABLED` | `true` | Required by future n8n versions |
| `N8N_DISABLE_POSTHOG` | `true` | Stops PostHog 401 errors (no API key set) |

### 4. Deploy

1. Go to your n8n Web Service
2. **Manual Deploy > Clear build cache & deploy**

## Troubleshooting

**Q: Server keeps restarting / JavaScript heap out of memory**
A: Render free tier has 512MB RAM. Set `NODE_OPTIONS=--max-old-space-size=384` to limit Node heap.

**Q: Permissions 0644 warning**
A: Set `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true`.

**Q: PostHog 401 errors in logs**
A: Set `N8N_DISABLE_POSTHOG=true` (non-critical, just noise).

## Updating

Update the `n8n` version in `package.json` and push to GitHub. Render auto-deploys.
