const notificationService = require('./services/notificationService');

async function testOrderNotification() {
    try {
        console.log('🚀 RabbitMQ Sipariş Bildirimi Testi Başlatılıyor...');
        
        // RabbitMQ bağlantısını başlat
        await notificationService.connect();
        console.log('✅ NotificationService bağlandı');
        
        // Test order data
        const orderData = {
            orderId: 12345,
            userId: 999,
            total: 299.99,
            orderItems: [
                { product_id: 1, quantity: 2 },
                { product_id: 2, quantity: 1 }
            ]
        };
        
        // Sipariş bildirimi gönder
        const result = await notificationService.sendOrderNotification(orderData);
        
        if (result) {
            console.log('✅ Sipariş bildirimi başarıyla gönderildi!');
        } else {
            console.log('❌ Sipariş bildirimi gönderilemedi');
        }
        
        console.log('🎯 Test tamamlandı. Worker terminalini kontrol edin!');
        
        // Bağlantıyı kapat
        await notificationService.close();
        
    } catch (error) {
        console.error('❌ Test hatası:', error.message);
    }
}

testOrderNotification();
