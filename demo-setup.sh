#!/bin/bash

# 🚀 RabbitMQ Demo Hazırlık Script'i
# Bu script demo öncesi tüm servisleri hazırlar

echo "🎯 RabbitMQ Demo Hazırlığı Başlatılıyor..."

# 1. RabbitMQ ve PostgreSQL'i başlat
echo "📡 RabbitMQ ve PostgreSQL başlatılıyor..."
cd /Users/astigmatograf/Desktop/proje/FullStack-ECommerce-App
docker compose up -d rabbitmq postgres

# 2. Servislerin hazır olmasını bekle
echo "⏳ Servislerin hazır olması bekleniyor..."
sleep 10

# 3. RabbitMQ durumunu kontrol et
echo "🔍 RabbitMQ durumu kontrol ediliyor..."
docker ps | grep rabbitmq

# 4. RabbitMQ bağlantısını test et
echo "🧪 RabbitMQ bağlantı testi..."
cd Back-End/SmartShop-Server
node test-rabbitmq.js

echo ""
echo "✅ Demo Hazırlığı Tamamlandı!"
echo ""
echo "🎯 Hocaya Gösterilecekler:"
echo "1. RabbitMQ Management Panel: http://localhost:15672"
echo "2. Worker'ı başlat: node workers/notificationWorker.js"
echo "3. Demo'yu çalıştır: node demo-rabbitmq.js"
echo ""
echo "🔐 RabbitMQ Login: admin / admin123"
