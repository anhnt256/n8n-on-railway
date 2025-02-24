FROM n8nio/n8n

# Chuyển sang user root để cài đặt packages
USER root

# Cài đặt googleapis
RUN npm install googleapis

# Cấu hình để cho phép sử dụng module bên ngoài
ENV NODE_FUNCTION_ALLOW_EXTERNAL=googleapis
ENV NPM_FLAGS=--prefix=/opt/n8n

# Thiết lập thư mục làm việc
WORKDIR /data

# Copy package.json nếu bạn có
COPY package*.json ./

# Cài đặt các dependencies
RUN npm install

# Copy các file khác
COPY . .

# Tạo thư mục data và set permissions
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n && \
    chown -R node:node /data

# Chuyển về node user để chạy ứng dụng
USER node

# Port mặc định của n8n
EXPOSE 5678

# Khởi chạy n8n
CMD ["n8n", "start"]
