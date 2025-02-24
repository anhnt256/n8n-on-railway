FROM n8nio/n8n:latest
USER root
RUN npm install googleapis
RUN ln -s /usr/local/lib/node_modules/googleapis /usr/local/lib/node_modules/n8n/node_modules/googleapis
USER node
