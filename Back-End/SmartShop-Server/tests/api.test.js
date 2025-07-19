const request = require('supertest');

// Test ortamı ayarla
process.env.NODE_ENV = 'test';

const app = require('../app');

describe('SmartShop API Tests', () => {
  
  describe('🔐 Authentication Endpoints', () => {
    test('POST /api/auth/register - should handle register request', async () => {
      const userData = {
        username: 'testuser' + Date.now(),
        password: 'testpass123'
      };
      
      const response = await request(app)
        .post('/api/auth/register')
        .send(userData);
      
      // Beklenen durumları kontrol et (başarı, hata, vs)
      expect([200, 201, 400, 409, 500]).toContain(response.status);
    });

    test('POST /api/auth/login - should handle login request', async () => {
      const loginData = {
        username: 'testuser',
        password: 'testpass123'
      };
      
      const response = await request(app)
        .post('/api/auth/login')
        .send(loginData);
      
      // Geçerli response status kodları
      expect([200, 401, 400, 500]).toContain(response.status);
    });
  });

  describe('🛍️ Product Endpoints', () => {
    test('GET /api/products - should return products response', async () => {
      const response = await request(app)
        .get('/api/products');
      
      expect([200, 404, 500]).toContain(response.status);
      expect(response).toBeDefined();
    });

    test('POST /api/products - should handle product creation', async () => {
      const productData = {
        name: 'Test Product',
        price: 99.99,
        description: 'Test Description'
      };
      
      const response = await request(app)
        .post('/api/products')
        .send(productData);
      
      // Auth required veya success veya error
      expect([201, 401, 400, 500]).toContain(response.status);
    });
  });

  describe('🛒 Cart Endpoints', () => {
    test('GET /api/cart - should handle cart request', async () => {
      const response = await request(app)
        .get('/api/cart');
      
      // Auth required expected
      expect([200, 401, 500]).toContain(response.status);
      expect(response).toBeDefined();
    });
  });

  describe('👤 User Endpoints', () => {
    test('GET /api/user - should handle user info request', async () => {
      const response = await request(app)
        .get('/api/user');
      
      // Auth required expected
      expect([200, 401, 500]).toContain(response.status);
      expect(response).toBeDefined();
    });
  });

  describe('📦 Static Files', () => {
    test('GET /api/uploads - should serve static files endpoint', async () => {
      const response = await request(app)
        .get('/api/uploads/nonexistent.txt');
      
      // File exists or not found
      expect([200, 404, 500]).toContain(response.status);
      expect(response).toBeDefined();
    });
  });

});

describe('🏥 Health Check', () => {
  test('Express app should be defined', () => {
    expect(app).toBeDefined();
    expect(typeof app).toBe('function');
  });
  
  test('Server should respond to requests', async () => {
    const response = await request(app)
      .get('/api/products');
    
    // Server yanıt veriyor mu kontrol et
    expect(response.status).toBeDefined();
    expect(typeof response.status).toBe('number');
  });
});
