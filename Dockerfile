FROM n8nio/n8n:latest
USER root
RUN npm install -g googleapis google-auth-library
USER node
