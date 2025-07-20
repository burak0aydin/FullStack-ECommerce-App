const amqp = require('amqplib');

async function testRabbitMQ() {
    try {
        console.log('🎯 RabbitMQ test başlatılıyor...');
        
        // Local RabbitMQ connection
        const connection = await amqp.connect('amqp://admin:admin123@localhost:5672');
        console.log('✅ RabbitMQ bağlantısı başarılı!');
        
        const channel = await connection.createChannel();
        console.log('✅ Channel oluşturuldu');
        
        const queueName = 'test_queue';
        await channel.assertQueue(queueName, { durable: true });
        console.log('✅ Queue oluşturuldu:', queueName);
        
        // Test mesajı gönder
        const testMessage = {
            type: 'TEST',
            message: 'RabbitMQ çalışıyor!',
            timestamp: new Date().toISOString()
        };
        
        channel.sendToQueue(queueName, Buffer.from(JSON.stringify(testMessage)));
        console.log('📨 Test mesajı gönderildi:', testMessage);
        
        // Mesajı al
        const message = await channel.get(queueName);
        if (message) {
            const data = JSON.parse(message.content.toString());
            console.log('📥 Mesaj alındı:', data);
            channel.ack(message);
        }
        
        await channel.close();
        await connection.close();
        console.log('🎉 RabbitMQ test başarılı!');
        
    } catch (error) {
        console.error('❌ RabbitMQ test hatası:', error.message);
    }
}

testRabbitMQ();
