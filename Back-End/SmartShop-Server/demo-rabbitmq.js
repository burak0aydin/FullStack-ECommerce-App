#!/usr/bin/env node
/**
 * 🎯 RabbitMQ Canlı Demo Script
 * Bu script hocaya RabbitMQ entegrasyonunu göstermek için hazırlanmıştır.
 */

const notificationService = require('./services/notificationService');

console.log('🚀 RabbitMQ Canlı Demo Başlatılıyor...\n');

async function runDemo() {
    try {
        // 1. RabbitMQ Bağlantısını Test Et
        console.log('📡 1. RabbitMQ Bağlantı Testi...');
        const isConnected = await notificationService.connect();
        
        if (!isConnected) {
            throw new Error('RabbitMQ bağlantısı kurulamadı!');
        }
        console.log('   ✅ RabbitMQ bağlantısı başarılı!\n');

        // 2. Demo Sipariş Mesajları Gönder
        console.log('📦 2. Demo Sipariş Mesajları Gönderiliyor...\n');

        const demoOrders = [
            {
                orderId: 1001,
                userId: 101,
                total: 149.99,
                customerName: 'Ahmet Yılmaz'
            },
            {
                orderId: 1002,
                userId: 102,
                total: 299.50,
                customerName: 'Ayşe Demir'
            },
            {
                orderId: 1003,
                userId: 103,
                total: 89.75,
                customerName: 'Mehmet Kaya'
            }
        ];

        // Her sipariş için bildirim gönder
        for (let i = 0; i < demoOrders.length; i++) {
            const order = demoOrders[i];
            
            console.log(`📨 Sipariş #${order.orderId} bildirimi gönderiliyor...`);
            console.log(`   👤 Müşteri: ${order.customerName}`);
            console.log(`   💰 Tutar: ${order.total}₺`);
            
            const result = await notificationService.sendOrderNotification(order);
            
            if (result) {
                console.log('   ✅ Bildirim başarıyla gönderildi!');
            } else {
                console.log('   ❌ Bildirim gönderilemedi');
            }
            
            console.log('   ⏱️  Worker terminalini kontrol edin...\n');
            
            // Biraz bekle
            await new Promise(resolve => setTimeout(resolve, 2000));
        }

        console.log('🎉 Demo Tamamlandı!');
        console.log('📱 RabbitMQ Management Panel: http://localhost:15672');
        console.log('🔐 Kullanıcı: admin / Şifre: admin123\n');
        
        // Bağlantıyı kapat
        await notificationService.close();
        console.log('👋 Bağlantı kapatıldı. Demo sona erdi.');
        
    } catch (error) {
        console.error('❌ Demo Hatası:', error.message);
    }
}

// Demo'yu çalıştır
runDemo();
