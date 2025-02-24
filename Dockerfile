FROM n8nio/n8n:latest
USER root
RUN npm install -g googleapis
ENV NODE_PATH="/data/node_modules"
ENV N8N_DISABLE_EXTERNAL_ACCESS_FOR_PUBLIC=true
USER node
