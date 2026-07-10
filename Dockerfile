FROM n8nio/n8n:2.27.4

WORKDIR /home/node

ENV N8N_USER_FOLDER=/home/node/.n8n

COPY --chown=node:node proxy.js /home/node/

EXPOSE 5678

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["export N8N_PORT=5679 && node /home/node/proxy.js & echo 'Proxy started' && exec n8n start"]
