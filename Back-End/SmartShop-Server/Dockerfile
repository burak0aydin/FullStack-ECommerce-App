# SmartShop Backend Dockerfile
FROM node:18-alpine

# Metadata
LABEL maintainer="Burak Aydın <burak@smartshop.com>"
LABEL description="SmartShop E-commerce Backend API"
LABEL version="1.0.0"

# Çalışma dizinini ayarla
WORKDIR /app

# Package files kopyala (cache optimization)
COPY package*.json ./

# Dependencies yükle
RUN npm ci --only=production && npm cache clean --force

# Source kodu kopyala
COPY . .

# Uploads klasörü oluştur
RUN mkdir -p uploads && chmod 755 uploads

# Non-root user oluştur (security)
RUN addgroup -g 1001 -S nodejs && \
    adduser -S smartshop -u 1001 -G nodejs

# Ownership değiştir
RUN chown -R smartshop:nodejs /app
USER smartshop

# Health check ekle
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD node -e "require('http').get('http://localhost:8080/api/products', (res) => { process.exit(res.statusCode === 200 ? 0 : 1) }).on('error', () => process.exit(1))"

# Port aç
EXPOSE 8080

# Uygulama başlat
CMD ["npm", "start"]
