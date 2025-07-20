const amqp = require('amqplib');

class NotificationWorker {
    constructor() {
        this.connection = null;
        this.channel = null;
        this.QUEUE_NAME = 'order_notifications';
    }

    async start() {
        try {
            console.log('🎯 RabbitMQ Notification Worker başlatılıyor...');
            
            // Connect to RabbitMQ
            this.connection = await amqp.connect('amqp://admin:admin123@localhost:5672');
            this.channel = await this.connection.createChannel();
            
            // Ensure queue exists
            await this.channel.assertQueue(this.QUEUE_NAME, {
                durable: true
            });

            // Set prefetch to handle one message at a time
            this.channel.prefetch(1);

            console.log('✅ RabbitMQ Worker hazır - mesajlar bekleniyor...');
            console.log(`📦 Queue: ${this.QUEUE_NAME}`);
            console.log('🔄 Mesajları işlemeye başladı...\n');

            // Consume messages
            this.channel.consume(this.QUEUE_NAME, (msg) => {
                if (msg) {
                    this.processMessage(msg);
                }
            });

            // Handle connection close
            this.connection.on('close', () => {
                console.log('❌ RabbitMQ bağlantısı kapandı');
                process.exit(1);
            });

        } catch (error) {
            console.error('❌ RabbitMQ Worker başlatma hatası:', error);
            process.exit(1);
        }
    }

    processMessage(msg) {
        try {
            const messageData = JSON.parse(msg.content.toString());
            
            console.log('📨 YENİ MESAJ ALINDI:', {
                timestamp: new Date().toLocaleString('tr-TR'),
                type: messageData.type,
                orderId: messageData.orderId,
                userId: messageData.userId,
                total: messageData.total,
                message: messageData.message
            });

            // Simulate notification processing (email, SMS, push notification, etc.)
            this.simulateNotificationProcessing(messageData);

            // Acknowledge message processing
            this.channel.ack(msg);

            console.log('✅ Mesaj başarıyla işlendi ve kuyruktan silindi\n');

        } catch (error) {
            console.error('❌ Mesaj işleme hatası:', error);
            
            // Reject message and don't requeue
            this.channel.nack(msg, false, false);
        }
    }

    simulateNotificationProcessing(data) {
        // Simulate different types of notifications
        console.log('📧 E-mail gönderiliyor...');
        console.log('📱 Push notification gönderiliyor...');
        console.log('📊 Analytics güncelleniyor...');
        console.log('💾 Log dosyasına kaydediliyor...');
        
        // Simulate processing time
        const processingTime = Math.random() * 1000 + 500; // 500-1500ms
        setTimeout(() => {
            console.log(`⏱️ İşleme süresi: ${processingTime.toFixed(0)}ms`);
        }, processingTime);
    }

    async stop() {
        try {
            if (this.channel) await this.channel.close();
            if (this.connection) await this.connection.close();
            console.log('🛑 RabbitMQ Worker durduruldu');
        } catch (error) {
            console.error('Worker durdurma hatası:', error);
        }
    }
}

// Create and start worker
const worker = new NotificationWorker();
worker.start();

// Handle graceful shutdown
process.on('SIGINT', async () => {
    console.log('\n🛑 Worker kapatılıyor...');
    await worker.stop();
    process.exit(0);
});

process.on('SIGTERM', async () => {
    console.log('\n🛑 Worker sonlandırılıyor...');
    await worker.stop();
    process.exit(0);
});
