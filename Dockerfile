FROM node:18-alpine
USER root
RUN npm install -g googleapis
USER node
