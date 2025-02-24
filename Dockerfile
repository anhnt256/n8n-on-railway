FROM n8nio/n8n

# Chuyển sang user root để cài đặt packages
USER root

# Cài đặt googleapis trực tiếp vào thư mục n8n
WORKDIR /usr/local/lib/node_modules/n8n
RUN npm install googleapis

# Cấu hình để cho phép sử dụng module bên ngoài
ENV NODE_FUNCTION_ALLOW_EXTERNAL=googleapis
ENV NPM_FLAGS=--prefix=/opt/n8n

# Tạo và set permissions cho thư mục data
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n && \
    mkdir -p /data && \
    chown -R node:node /data

# Chuyển về node user để chạy ứng dụng
USER node

# Thiết lập thư mục làm việc
WORKDIR /data

# Port mặc định của n8n
EXPOSE 5678

# Khởi chạy n8n
CMD ["n8n", "start"]
