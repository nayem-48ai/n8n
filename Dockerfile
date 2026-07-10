FROM n8nio/n8n:2.27.4

WORKDIR /home/node

ENV N8N_USER_FOLDER=/home/node/.n8n

ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_HOST=ep-twilight-forest-aojc4ipo.c-2.ap-southeast-1.aws.neon.tech
ENV DB_POSTGRESDB_PORT=5432
ENV DB_POSTGRESDB_DATABASE=neondb
ENV DB_POSTGRESDB_USER=neondb_owner
ENV DB_POSTGRESDB_PASSWORD=npg_MDLebgSJ2k6x
ENV DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false

ENV NODE_OPTIONS="--dns-result-order=ipv4first"

ENV N8N_HOST=n8n-3f4f.onrender.com
ENV N8N_PROTOCOL=https
ENV WEBHOOK_URL=https://n8n-3f4f.onrender.com/
ENV N8N_EDITOR_BASE_URL=https://n8n-3f4f.onrender.com

EXPOSE 5678

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
CMD ["start"]
