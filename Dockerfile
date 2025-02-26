FROM n8nio/n8n:latest
# Chạy lệnh dưới quyền root để cài đặt package
USER root
RUN npm install -g googleapis \
    && npm install googleapis --prefix /usr/local/lib/node_modules/n8n/node_modules \
    && chown -R node:node /usr/local/lib/node_modules/n8n/node_modules/googleapis

# Chuyển về user node để tránh lỗi quyền hạn khi chạy n8n
USER node
