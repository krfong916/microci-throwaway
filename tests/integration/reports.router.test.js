import app from '../../app';
import supertest from 'supertest';

describe('reports router integration test', () => {
  let server, request;

  beforeEach(() => {
    server = app.listen(3001);
    request = supertest(app);
  });

  afterEach(async done => {
    await server.close(done);
  });

  test('get reports endpoint', async () => {
    const response = await request.get('/reports/1');
    expect(response.status).toEqual(200);
    expect(response.body).toBeDefined();
  });
});
