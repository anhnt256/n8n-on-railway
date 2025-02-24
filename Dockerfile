FROM n8nio/n8n:latest
USER root
RUN npm -g install googleapis
USER node
