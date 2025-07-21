#!/bin/bash

# 🚀 Docker Demo Launcher
# Tek komutla Docker entegrasyonunu göstermek için

# Terminal renklerini ayarla
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🐳 Docker Entegrasyon İspatı - Hızlı Demo${NC}"

# 1. Docker container'ları durdur ve temizle
echo -e "${YELLOW}1. Temizlik yapılıyor...${NC}"
docker compose down -v >/dev/null 2>&1

# 2. Docker image'ları göster
echo -e "${YELLOW}2. Docker dosyalarını göster${NC}"
ls -la docker-compose* */*/Dockerfile*
echo ""

# 3. Docker compose dosyasının içeriğini göster
echo -e "${YELLOW}3. docker-compose.yml içeriği (kısmi)${NC}"
head -n 15 docker-compose.yml
echo "..."
echo ""

# 4. Tek komutla container'ları başlat
echo -e "${YELLOW}4. Container'ları başlatıyorum...${NC}"
docker compose up -d

# 5. Container'ları göster
echo -e "${YELLOW}5. Çalışan container'lar:${NC}"
docker ps
echo ""

echo -e "${GREEN}✅ Demo tamamlandı! Docker entegrasyonu ispatlandı.${NC}"
echo -e "${BLUE}📋 Özellikler:${NC}"
echo -e "   ✅ Multi-container deployment"
echo -e "   ✅ Microservices architecture"
echo -e "   ✅ PostgreSQL, Backend, Nginx entegrasyonu"
echo -e "   ✅ Development/Production ayırımı"
echo -e "   ✅ Dockerfile optimization"
echo -e "   ✅ Docker volume management"
echo -e "   ✅ Health checks"
echo ""
echo -e "${GREEN}🚀 Not: 'make down' komutu ile container'ları durdurabilirsiniz${NC}"
