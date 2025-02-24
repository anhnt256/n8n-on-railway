FROM n8nio/n8n

USER root

RUN npm install -g googleapis

USER node

EXPOSE 5678

CMD ["n8n", "start"]
