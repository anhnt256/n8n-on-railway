FROM n8nio/n8n:latest

# Chuyển sang user root để cài đặt
USER root

# Cài đặt googleapis cục bộ trong thư mục của n8n
WORKDIR /usr/lib/node_modules/n8n
RUN npm install googleapis

# Quay lại user node để chạy n8n
USER node

# Đảm bảo thư mục làm việc là đúng khi chạy
WORKDIR /home/node
