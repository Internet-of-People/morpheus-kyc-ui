import express from 'express';
import { Application } from 'express';

class Server {
  private app: Application;

  constructor() {
    this.app = express();
  }

  public start(): void {
    this.app.get('/morpheus/witness-service', async (req, res) => {
      res.status(200).json({});
    });
    this.app.listen(8080, () => {
      console.log('Listening on 8080');
    });
  }
}

new Server().start();
