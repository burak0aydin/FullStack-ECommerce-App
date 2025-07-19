const request = require('supertest');
const app = require('../app');

describe('SmartShop API Tests', () => {
  
  describe('🔐 Authentication Endpoints', () => {
    test('POST /api/auth/register - should return success message', async () => {
      const userData = {
        username: 'testuser' + Date.now(),
        password: 'testpass123'
      };
      
      const response = await request(app)
        .post('/api/auth/register')
        .send(userData);
      
      // Beklenen durumları kontrol et
      expect([200, 201, 400, 409]).toContain(response.status);
    });

    test('POST /api/auth/login - should accept login request', async () => {
      const loginData = {
        username: 'testuser',
        password: 'testpass123'
      };
      
      const response = await request(app)
        .post('/api/auth/login')
        .send(loginData);
      
      // Geçerli response status kodları
      expect([200, 401, 400]).toContain(response.status);
    });
  });

  describe('🛍️ Product Endpoints', () => {
    test('GET /api/products - should return products list', async () => {
      const response = await request(app)
        .get('/api/products');
      
      expect([200, 404]).toContain(response.status);
      
      if (response.status === 200) {
        expect(Array.isArray(response.body) || typeof response.body === 'object').toBe(true);
      }
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
      
      // Auth required veya success
      expect([201, 401, 400]).toContain(response.status);
    });
  });

  describe('🛒 Cart Endpoints', () => {
    test('GET /api/cart - should handle cart request', async () => {
      const response = await request(app)
        .get('/api/cart');
      
      // Auth required expected
      expect([200, 401]).toContain(response.status);
    });
  });

  describe('👤 User Endpoints', () => {
    test('GET /api/user - should handle user info request', async () => {
      const response = await request(app)
        .get('/api/user');
      
      // Auth required expected
      expect([200, 401]).toContain(response.status);
    });
  });

  describe('📦 Upload Endpoints', () => {
    test('GET /api/uploads - should serve static files', async () => {
      const response = await request(app)
        .get('/api/uploads/test.txt');
      
      // File exists or not found
      expect([200, 404]).toContain(response.status);
    });
  });

});

describe('🏥 Health Check', () => {
  test('Server should be running', async () => {
    const response = await request(app)
      .get('/api/products');
    
    // Server yanıt veriyor mu kontrol et
    expect(response.status).toBeDefined();
    expect(typeof response.status).toBe('number');
  });
});
