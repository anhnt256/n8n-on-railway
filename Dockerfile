FROM n8nio/n8n

# Chuyển sang user root để cài đặt packages
USER root

# Cài đặt googleapis ở nhiều vị trí để đảm bảo VM2 có thể tìm thấy
RUN npm install -g googleapis && \
    cd /usr/local/lib/node_modules/n8n && npm install googleapis && \
    cd /usr/local/lib/node_modules/n8n/node_modules/n8n-nodes-base && npm install googleapis

# Cấu hình để cho phép sử dụng module bên ngoài
ENV NODE_FUNCTION_ALLOW_EXTERNAL=googleapis
ENV NODE_FUNCTION_ALLOW_EXTERNAL=* 
ENV N8N_SKIP_WEBHOOK_VALIDATION=true

# Tạo và set permissions cho các thư mục
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n && \
    mkdir -p /data && \
    chown -R node:node /data && \
    chown -R node:node /usr/local/lib/node_modules/n8n

# Chuyển về node user để chạy ứng dụng
USER node

# Thiết lập thư mục làm việc
WORKDIR /data

# Port mặc định của n8n
EXPOSE 5678

# Khởi chạy n8n
CMD ["n8n", "start"]
