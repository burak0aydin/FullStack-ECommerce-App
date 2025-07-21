const { createClient } = require('redis');

class RedisService {
    constructor() {
        this.client = null;
        this.isConnected = false;
        this.CACHE_TTL = 3600; // Default cache TTL: 1 hour (in seconds)
    }

    async connect() {
        try {
            console.log('🔄 Redis bağlantısı kuruluyor...');
            
            // Create Redis client
            this.client = createClient({
                url: process.env.REDIS_URL || 'redis://localhost:6379'
            });

            // Setup event handlers
            this.client.on('error', (err) => {
                console.error('❌ Redis Error:', err);
                this.isConnected = false;
            });

            this.client.on('reconnecting', () => {
                console.log('🔄 Redis ile yeniden bağlantı kuruluyor...');
                this.isConnected = false;
            });

            this.client.on('ready', () => {
                console.log('✅ Redis bağlantısı başarılı!');
                this.isConnected = true;
            });

            // Connect to Redis
            await this.client.connect();
            this.isConnected = true;
            
            return true;
        } catch (error) {
            console.error('❌ Redis bağlantı hatası:', error.message);
            this.isConnected = false;
            return false;
        }
    }

    /**
     * Set a value in Redis cache
     * @param {string} key - Cache key
     * @param {any} value - Value to cache (will be JSON stringified)
     * @param {number} ttl - Time to live in seconds
     */
    async set(key, value, ttl = this.CACHE_TTL) {
        try {
            if (!this.isConnected) {
                await this.connect();
            }
            
            if (!this.isConnected) {
                return false;
            }

            const serializedValue = JSON.stringify(value);
            await this.client.set(key, serializedValue, { EX: ttl });
            
            return true;
        } catch (error) {
            console.error('❌ Redis set hatası:', error.message);
            return false;
        }
    }

    /**
     * Get a value from Redis cache
     * @param {string} key - Cache key
     * @returns {any|null} - Parsed value or null if not found
     */
    async get(key) {
        try {
            if (!this.isConnected) {
                await this.connect();
            }
            
            if (!this.isConnected) {
                return null;
            }

            const value = await this.client.get(key);
            
            if (!value) {
                return null;
            }
            
            return JSON.parse(value);
        } catch (error) {
            console.error('❌ Redis get hatası:', error.message);
            return null;
        }
    }

    /**
     * Delete a key from Redis cache
     * @param {string} key - Cache key to delete
     */
    async delete(key) {
        try {
            if (!this.isConnected) {
                await this.connect();
            }
            
            if (!this.isConnected) {
                return false;
            }

            await this.client.del(key);
            return true;
        } catch (error) {
            console.error('❌ Redis delete hatası:', error.message);
            return false;
        }
    }

    /**
     * Clear all keys from the current database
     */
    async flushAll() {
        try {
            if (!this.isConnected) {
                await this.connect();
            }
            
            if (!this.isConnected) {
                return false;
            }

            await this.client.flushAll();
            return true;
        } catch (error) {
            console.error('❌ Redis flushAll hatası:', error.message);
            return false;
        }
    }

    /**
     * Close Redis connection
     */
    async close() {
        try {
            if (this.client) {
                await this.client.quit();
                this.isConnected = false;
                console.log('👋 Redis bağlantısı kapatıldı');
            }
        } catch (error) {
            console.error('❌ Redis kapatma hatası:', error.message);
        }
    }
}

module.exports = new RedisService();
