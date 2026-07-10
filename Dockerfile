FROM n8nio/n8n:2.27.4

WORKDIR /home/node

ENV N8N_USER_FOLDER=/home/node/.n8n

COPY proxy.js start.sh /home/node/

EXPOSE 5678

CMD ["/home/node/start.sh"]
