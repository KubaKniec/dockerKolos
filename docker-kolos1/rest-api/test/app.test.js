const request = require('supertest');
const app = require('../server');

describe('Test serwera REST', () => {
  it('Powinien zwrócić "Hello, World!"', async () => {
    const response = await request(app).get('/');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('Hello, World!');
  });
});
