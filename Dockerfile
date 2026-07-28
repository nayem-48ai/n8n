FROM n8nio/n8n:2.27.4

WORKDIR /home/node

ENV N8N_USER_FOLDER=/home/node/.n8n

ENV N8N_HOST=n8n-3f4f.onrender.com
ENV N8N_PROTOCOL=https
ENV WEBHOOK_URL=https://n8n-3f4f.onrender.com/
ENV N8N_EDITOR_BASE_URL=https://n8n-3f4f.onrender.com

ENV EXECUTIONS_DATA_PRUNE=true
ENV EXECUTIONS_DATA_MAX_AGE=168
ENV N8N_DISABLE_POSTHOG=true
ENV N8N_RUNNERS_ENABLED=false

ENV NODE_OPTIONS="--max-old-space-size=384 --dns-result-order=ipv4first"

EXPOSE 5678

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
CMD ["start"]
