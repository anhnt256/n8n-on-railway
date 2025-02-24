FROM n8nio/n8n:latest
USER root
RUN npm install -g googleapis --force --legacy-peer-deps
USER node
