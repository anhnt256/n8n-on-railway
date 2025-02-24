FROM node:18-alpine
WORKDIR /home/node
COPY . .
RUN npm install
RUN npm install googleapis  # Thêm dòng này
CMD ["n8n"]
