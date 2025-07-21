-- SmartShop Database Initialization
-- Bu dosya PostgreSQL container başlatıldığında otomatik çalışır

-- Database hazır mesajı
SELECT 'SmartShop database initialized successfully!' as message;

-- Temel ayarlar
SET timezone = 'UTC';

-- Sequelize migration'lar için hazırlık
-- Migration'lar uygulama başlatıldığında otomatik çalışacak
