const amqp = require('amqplib');

class NotificationService {
    constructor() {
        this.connection = null;
        this.channel = null;
        this.QUEUE_NAME = 'order_notifications';
    }

    async connect() {
        try {
            // RabbitMQ connection
            this.connection = await amqp.connect('amqp://admin:admin123@localhost:5672');
            this.channel = await this.connection.createChannel();
            
            // Ensure queue exists
            await this.channel.assertQueue(this.QUEUE_NAME, {
                durable: true // Queue survives RabbitMQ restarts
            });
            
            console.log('✅ RabbitMQ bağlantısı başarılı - NotificationService aktif');
            return true;
        } catch (error) {
            console.log('⚠️ RabbitMQ bağlantı hatası (devam edilecek):', error.message);
            return false;
        }
    }

    async sendOrderNotification(orderData) {
        try {
            if (!this.channel) {
                await this.connect();
            }

            if (!this.channel) {
                console.log('⚠️ RabbitMQ kullanılamıyor - mesaj gönderilmedi');
                return false;
            }

            const message = {
                type: 'ORDER_CREATED',
                orderId: orderData.orderId,
                userId: orderData.userId,
                total: orderData.total,
                timestamp: new Date().toISOString(),
                message: `Yeni sipariş oluşturuldu! Sipariş ID: ${orderData.orderId}, Tutar: ${orderData.total}₺`
            };

            // Send message to queue
            this.channel.sendToQueue(
                this.QUEUE_NAME, 
                Buffer.from(JSON.stringify(message)),
                { persistent: true }
            );

            console.log('🚀 RabbitMQ Mesajı Gönderildi:', {
                queue: this.QUEUE_NAME,
                orderId: orderData.orderId,
                total: orderData.total
            });

            return true;
        } catch (error) {
            console.log('⚠️ RabbitMQ mesaj gönderme hatası:', error.message);
            return false;
        }
    }

    async close() {
        try {
            if (this.channel) await this.channel.close();
            if (this.connection) await this.connection.close();
        } catch (error) {
            console.log('RabbitMQ kapatma hatası:', error.message);
        }
    }
}

module.exports = new NotificationService();
