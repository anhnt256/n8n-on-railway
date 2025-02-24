FROM n8nio/n8n

# Chuyển sang user root để cài đặt packages
USER root

# Cài đặt googleapis trong môi trường VM2
RUN cd /usr/local/lib/node_modules/n8n/node_modules/@n8n/vm2 && \
    npm install googleapis && \
    cd /usr/local/lib/node_modules/n8n && \
    npm install googleapis && \
    npm install -g googleapis

# Cấu hình VM2 và n8n để cho phép external modules
ENV NODE_FUNCTION_ALLOW_EXTERNAL=googleapis,lodash,moment
ENV N8N_SKIP_WEBHOOK_VALIDATION=true
ENV N8N_VM_TIMEOUT=30000

# Tạo symbolic links để VM2 có thể tìm thấy modules
RUN ln -s /usr/local/lib/node_modules/googleapis /usr/local/lib/node_modules/n8n/node_modules/@n8n/vm2/node_modules/googleapis

# Set permissions cho VM2
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n && \
    mkdir -p /data && \
    chown -R node:node /data && \
    chown -R node:node /usr/local/lib/node_modules/n8n && \
    chmod -R 755 /usr/local/lib/node_modules/n8n/node_modules/@n8n/vm2/node_modules

# Chuyển về node user để chạy ứng dụng
USER node

# Thiết lập thư mục làm việc
WORKDIR /data

# Port mặc định của n8n
EXPOSE 5678

# Khởi chạy n8n với production mode
CMD ["n8n", "start"]
