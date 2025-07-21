#!/bin/bash

# 🐰 RabbitMQ Demo - Hoca İspatı
# Burak Aydın - Message Queue Entegrasyonu

# Terminal renklerini ayarla
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🐰 RabbitMQ Entegrasyon İspatı - Hızlı Demo${NC}"
echo -e "${BLUE}============================================${NC}"

# 1. RabbitMQ servisi kontrol et
echo -e "${YELLOW}1. RabbitMQ servisi kontrol ediliyor...${NC}"
if docker ps | grep -q rabbitmq; then
    echo -e "${GREEN}✅ RabbitMQ container çalışıyor${NC}"
    RABBITMQ_RUNNING=true
else
    echo -e "${RED}❌ RabbitMQ container çalışmıyor${NC}"
    echo -e "${YELLOW}🔄 RabbitMQ başlatılıyor...${NC}"
    docker compose up -d rabbitmq
    echo -e "${YELLOW}⏳ RabbitMQ'nun başlaması bekleniyor (15 saniye)...${NC}"
    sleep 15
    RABBITMQ_RUNNING=true
    echo -e "${GREEN}✅ RabbitMQ başlatıldı${NC}"
fi
echo ""

# 2. RabbitMQ kod entegrasyonunu göster
echo -e "${YELLOW}2. RabbitMQ Kod Entegrasyonu${NC}"
echo -e "${CYAN}📄 Kod dosyaları:${NC}"
echo -e "   - services/notificationService.js (Producer)"
echo -e "   - workers/notificationWorker.js (Consumer)"
echo -e "   - demo-rabbitmq.js (Demo Script)"
echo -e "   - controllers/orderController.js (Entegrasyon)"
echo ""

echo -e "${CYAN}📚 RabbitMQ Mimarisi:${NC}"
echo -e "   - Producer: OrderController (sipariş oluşturulduğunda)"
echo -e "   - Queue: order_notifications (durable queue)"
echo -e "   - Consumer: NotificationWorker (background process)"
echo -e "   - Message Format: JSON (sipariş bilgileri)"
echo ""

# 3. RabbitMQ Management Panel URL göster
echo -e "${YELLOW}3. RabbitMQ Management Panel${NC}"
echo -e "${CYAN}🌐 URL: http://localhost:15672${NC}"
echo -e "${CYAN}🔑 Login: admin / admin123${NC}"
echo ""

# 4. Demo adımları göster
echo -e "${YELLOW}4. Canlı Demo Adımları${NC}"
echo -e "${CYAN}1. Worker'ı başlat${NC} (yeni terminal açın):"
echo -e "   cd /Users/astigmatograf/Desktop/10/FullStack-ECommerce-App/Back-End/SmartShop-Server"
echo -e "   node workers/notificationWorker.js"
echo ""
echo -e "${CYAN}2. Demo mesajları gönder${NC} (yeni terminal açın):"
echo -e "   cd /Users/astigmatograf/Desktop/10/FullStack-ECommerce-App/Back-End/SmartShop-Server"
echo -e "   node demo-rabbitmq.js"
echo ""

# 5. Özet ve teknik özellikler
echo -e "${YELLOW}5. Teknik Özellikler${NC}"
echo -e "${CYAN}✅ Asynchronous Processing:${NC} Sipariş hızla tamamlanır, bildirimler arka planda işlenir"
echo -e "${CYAN}✅ Reliable Messaging:${NC} Mesajlar kalıcıdır, RabbitMQ yeniden başlatılsa bile kaybolmaz"
echo -e "${CYAN}✅ Error Handling:${NC} RabbitMQ down olsa bile uygulama çalışmaya devam eder"
echo -e "${CYAN}✅ Scalability:${NC} Birden fazla worker instance çalıştırılabilir"
echo -e "${CYAN}✅ Message Acknowledgment:${NC} İşlenen mesajlar kuyruktan silinir"
echo ""

echo -e "${GREEN}🚀 Demo Hazır!${NC}"
echo -e "${BLUE}Yukarıdaki adımları takip ederek RabbitMQ entegrasyonunu hocaya gösterebilirsiniz.${NC}"
echo -e "${YELLOW}Not: Hocaya RabbitMQ'nun ne olduğunu ve neden kullandığınızı kısaca açıklamayı unutmayın.${NC}"
echo ""
