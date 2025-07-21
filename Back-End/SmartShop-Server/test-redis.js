/**
 * Redis Cache Test Script
 * Bu script Redis cache entegrasyonunu test etmek için kullanılır.
 */

const redisService = require('./services/redisService');

async function testRedisCache() {
    console.log('🚀 Redis Cache Test Başlatılıyor...');
    
    try {
        // 1. Redis'e bağlan
        console.log('📡 Redis bağlantısı kuruluyor...');
        await redisService.connect();
        
        // 2. Cache'e veri yaz
        console.log('📥 Redis cache\'e veri yazılıyor...');
        const testData = {
            id: 1,
            name: 'Test Ürün',
            price: 99.99,
            timestamp: new Date().toISOString()
        };
        
        await redisService.set('test_key', testData, 60); // 60 saniye TTL
        console.log('✅ Veri başarıyla yazıldı:', testData);
        
        // 3. Cache'den veri oku
        console.log('📤 Redis cache\'den veri okunuyor...');
        const cachedData = await redisService.get('test_key');
        
        if (cachedData) {
            console.log('✅ Cache\'den okunan veri:', cachedData);
            console.log('🔍 Cache hit: Veri başarıyla önbellekten alındı!');
        } else {
            console.log('❌ Cache miss: Veri önbellekte bulunamadı!');
        }
        
        // 4. Cache'den bir veriyi sil
        console.log('🗑️ Redis cache\'den veri siliniyor...');
        await redisService.delete('test_key');
        console.log('✅ Veri başarıyla silindi!');
        
        // 5. Silinen veriyi tekrar oku (null olmalı)
        console.log('🔍 Silinen veri kontrol ediliyor...');
        const deletedData = await redisService.get('test_key');
        
        if (!deletedData) {
            console.log('✅ Test başarılı: Veri başarıyla silindi!');
        } else {
            console.log('❌ Test başarısız: Veri hala cache\'de mevcut!');
        }
        
        // 6. Performans testi
        console.log('\n⏱️ Performans testi başlatılıyor...');
        
        console.log('📊 100 veri yazma/okuma işlemi gerçekleştiriliyor...');
        const startTime = Date.now();
        
        for (let i = 0; i < 100; i++) {
            await redisService.set(`perf_key_${i}`, { value: `test_${i}`, index: i }, 60);
            await redisService.get(`perf_key_${i}`);
        }
        
        const endTime = Date.now();
        const duration = endTime - startTime;
        
        console.log(`✅ Performans testi tamamlandı: ${duration}ms (${duration/100}ms/işlem)`);
        
        // 7. Temizlik
        console.log('\n🧹 Test verileri temizleniyor...');
        for (let i = 0; i < 100; i++) {
            await redisService.delete(`perf_key_${i}`);
        }
        
        console.log('🎉 Redis Cache testi başarıyla tamamlandı!');
        console.log('📋 Redis, projenizde aşağıdaki amaçlarla kullanılmaktadır:');
        console.log('   - Ürün listelerini önbellekleme (performans artışı)');
        console.log('   - Kullanıcıya özel ürün listelerini önbellekleme');
        console.log('   - Sık erişilen verileri önbellekleme');
        console.log('   - Veritabanı yükünü azaltma');
        console.log('   - API yanıt sürelerini iyileştirme');
        
        // Bağlantıyı kapat
        await redisService.close();
        
    } catch (error) {
        console.error('❌ Redis test hatası:', error.message);
    }
}

// Testi çalıştır
testRedisCache();
