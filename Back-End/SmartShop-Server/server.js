// server.js - Production server başlatma dosyası
const app = require('./app');

const PORT = process.env.PORT || 8080;
const HOST = process.env.HOST || '0.0.0.0';

app.listen(PORT, HOST, () => {
    console.log(`🚀 SmartShop Server is running on http://${HOST}:${PORT}`);
    console.log(`🌐 Network access: http://192.168.1.39:${PORT}`);
    console.log(`📚 API Documentation: http://${HOST}:${PORT}/api/products`);
    console.log(`🛠️  Environment: ${process.env.NODE_ENV || 'development'}`);
});
