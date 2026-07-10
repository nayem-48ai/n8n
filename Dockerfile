FROM n8nio/n8n:2.27.4

WORKDIR /home/node

ENV N8N_USER_FOLDER=/home/node/.n8n

COPY --chown=node:node proxy.js start.sh /home/node/

RUN chmod +x /home/node/start.sh /home/node/proxy.js

EXPOSE 5678

ENTRYPOINT []
CMD ["/home/node/start.sh"]
