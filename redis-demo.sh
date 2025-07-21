#!/bin/bash

# 🔄 Redis Demo - Hoca İspatı
# Burak Aydın - Redis Cache Entegrasyonu

# Terminal renklerini ayarla
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🔄 Redis Cache Entegrasyon İspatı - Hızlı Demo${NC}"
echo -e "${BLUE}============================================${NC}"

# 1. Redis servisi kontrol et
echo -e "${YELLOW}1. Redis servisi kontrol ediliyor...${NC}"
if docker ps | grep -q redis; then
    echo -e "${GREEN}✅ Redis container çalışıyor${NC}"
    REDIS_RUNNING=true
else
    echo -e "${RED}❌ Redis container çalışmıyor${NC}"
    echo -e "${YELLOW}🔄 Redis başlatılıyor...${NC}"
    docker compose up -d redis
    echo -e "${YELLOW}⏳ Redis'in başlaması bekleniyor (10 saniye)...${NC}"
    sleep 10
    REDIS_RUNNING=true
    echo -e "${GREEN}✅ Redis başlatıldı${NC}"
fi
echo ""

# 2. Redis kod entegrasyonunu göster
echo -e "${YELLOW}2. Redis Kod Entegrasyonu${NC}"
echo -e "${CYAN}📄 Kod dosyaları:${NC}"
echo -e "   - services/redisService.js (Redis Client)"
echo -e "   - controllers/productController.js (Cache Implementation)"
echo -e "   - test-redis.js (Demo Script)"
echo -e ""

echo -e "${CYAN}📚 Redis Entegrasyon Noktaları:${NC}"
echo -e "   - Ürün listelerini önbellekleme (tüm ürünler)"
echo -e "   - Kullanıcıya özel ürün listelerini önbellekleme"
echo -e "   - Ürün ekleme/silme/güncelleme işlemlerinde cache invalidation"
echo ""

# 3. Redis test script'ini çalıştır
echo -e "${YELLOW}3. Redis Test Adımları${NC}"
echo -e "${CYAN}1. Test scriptini çalıştırın:${NC}"
echo -e "   cd /Users/astigmatograf/Desktop/10/FullStack-ECommerce-App/Back-End/SmartShop-Server"
echo -e "   node test-redis.js"
echo ""

# 4. Projedeki Redis kullanımını anlat
echo -e "${YELLOW}4. Redis Kullanım Amaçları${NC}"
echo -e "${CYAN}✅ Performans İyileştirmesi:${NC} Sık erişilen veriler önbellekte tutularak DB yükü azaltılır"
echo -e "${CYAN}✅ Yanıt Süreleri:${NC} API endpoint'leri daha hızlı yanıt verir"
echo -e "${CYAN}✅ Ölçeklenebilirlik:${NC} Veritabanı sunucusuna giden istek sayısı azalır"
echo -e "${CYAN}✅ Kullanıcı Deneyimi:${NC} Ürün listeleme ve arama işlemleri hızlanır"
echo -e "${CYAN}✅ Servis Dayanıklılığı:${NC} Veritabanı geçici olarak erişilmez olsa bile veri sunulabilir"
echo ""

# 5. Redis URL ve bağlantı bilgileri
echo -e "${YELLOW}5. Redis Bağlantı Bilgileri${NC}"
echo -e "${CYAN}🌐 Redis URL:${NC} redis://localhost:6379"
echo -e "${CYAN}📋 Docker Container:${NC} smartshop-redis"
echo -e "${CYAN}💾 Data Persistence:${NC} redis_data volume'ünde saklanıyor"
echo ""

echo -e "${GREEN}🚀 Demo Hazır!${NC}"
echo -e "${BLUE}Yukarıdaki adımları takip ederek Redis entegrasyonunu hocaya gösterebilirsiniz.${NC}"
echo -e "${YELLOW}Not: Hocaya Redis'in ne olduğunu ve neden kullandığınızı kısaca açıklamayı unutmayın.${NC}"
echo ""
