import express from 'express';
import { Application } from 'express';
import confirmedEUCitizenSchema from './confirmedEUCitizenSchema.json';
import processes from './processes.json';

class Server {
  private static readonly ROOT_PATH: string = '/morpheus/witness-service'; 
  private app: Application;

  constructor() {
    this.app = express();
  }

  public start(): void {
    this.app.get(`${Server.ROOT_PATH}/processes/list`, async (_, res): Promise<void> => {
      res.status(200).json({
        // http://127.0.0.1:8080/morpheus/witness-service/claim-schemas/confirmedEUCitizen
        processes,
      });
    });

    this.app.get(`${Server.ROOT_PATH}/claim-schemas/confirmedEUCitizen`, async (_, res): Promise<void> => {
      res.status(200).json(confirmedEUCitizenSchema);
    });

    this.app.post(`${Server.ROOT_PATH}/witness-request/confirmedEUCitizen/sign`, async (req, res): Promise<void> => {
      const { body } = req;
      console.log(body); // signed claim request
      res.status(200).json({"soon":"it will here"});
    });

    this.app.listen(8080, (): void => {
      console.log('Listening on 8080');
    });
  }
}

new Server().start();
