FROM n8nio/n8n

# Chuyển sang user root
USER root

# Cài đặt googleapis ở tất cả các vị trí cần thiết
RUN npm install -g googleapis && \
    cd /usr/local/lib/node_modules/n8n && \
    npm install googleapis && \
    # Cài đặt trong thư mục gốc của n8n
    mkdir -p /usr/local/lib/node_modules/n8n/dist/node_modules && \
    cd /usr/local/lib/node_modules/n8n/dist/node_modules && \
    npm install googleapis && \
    # Cài đặt trong VM2 sandbox
    mkdir -p /usr/local/lib/node_modules/n8n/node_modules/@n8n/vm2/node_modules && \
    cd /usr/local/lib/node_modules/n8n/node_modules/@n8n/vm2/node_modules && \
    npm install googleapis && \
    # Cài đặt trong nodes-base
    cd /usr/local/lib/node_modules/n8n/node_modules/n8n-nodes-base && \
    npm install googleapis

# Tạo symbolic links để đảm bảo VM2 có thể tìm thấy module
RUN ln -s /usr/local/lib/node_modules/googleapis /usr/local/lib/node_modules/n8n/node_modules/googleapis && \
    ln -s /usr/local/lib/node_modules/googleapis /usr/local/lib/node_modules/n8n/dist/node_modules/googleapis && \
    ln -s /usr/local/lib/node_modules/googleapis /usr/local/lib/node_modules/n8n/node_modules/@n8n/vm2/node_modules/googleapis

# Thiết lập quyền truy cập
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n && \
    mkdir -p /data && \
    chown -R node:node /data && \
    chown -R node:node /usr/local/lib/node_modules/n8n && \
    chmod -R 755 /usr/local/lib/node_modules/n8n/node_modules/@n8n/vm2/node_modules && \
    chmod -R 755 /usr/local/lib/node_modules/n8n/dist/node_modules

# Environment variables
ENV NODE_FUNCTION_ALLOW_EXTERNAL=googleapis,lodash,moment \
    N8N_METRICS=false \
    N8N_DIAGNOSTICS=false \
    N8N_USER_FOLDER=/home/node/.n8n \
    NODE_ENV=production \
    N8N_STRIP_NEXT_CLOUD_BASEURL=true \
    GENERIC_TIMEZONE=Asia/Ho_Chi_Minh \
    N8N_SYNC_NODE_PACKAGES_FOLDERS_ON_STARTUP=true \
    N8N_SKIP_WEBHOOK_VALIDATION=true \
    N8N_VM_TIMEOUT=30000

# Chuyển về node user
USER node

WORKDIR /data
EXPOSE 5678

CMD ["n8n", "start"]
