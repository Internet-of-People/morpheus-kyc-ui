import express from 'express';
import { Application } from 'express';
import confirmedEUCitizenClaimSchema from './confirmedEUCitizenClaimSchema.json';
import confirmedEUCitizenEvidenceSchema from './confirmedEUCitizenEvidenceSchema.json';
import processes from './processes.json';

class Server {
  private static readonly ROOT_PATH: string = '/morpheus/witness-service'; 
  private static readonly SLEEP_TIME_SEC: number = 2;
  private app: Application;

  constructor() {
    this.app = express();
  }

  public start(): void {
    this.app.get(`${Server.ROOT_PATH}/processes/list`, async (_, res): Promise<void> => {
      console.log('Serving processes/list...');
      await this.sleep();
      // claimSchema: http://10.0.2.2:8080/morpheus/witness-service/claim-schemas/confirmedEUCitizen
      // evidenceSchema: http://10.0.2.2:8080/morpheus/witness-service/evidence-schemas/confirmedEUCitizen
      console.log('Served');
      res.status(200).json({processes});
    });

    this.app.get(`${Server.ROOT_PATH}/claim-schemas/confirmedEUCitizen`, async (_, res): Promise<void> => {
      await this.sleep();
      res.status(200).json(confirmedEUCitizenClaimSchema);
    });

    this.app.get(`${Server.ROOT_PATH}/evidence-schemas/confirmedEUCitizen`, async (_, res): Promise<void> => {
      await this.sleep();
      res.status(200).json(confirmedEUCitizenEvidenceSchema);
    });

    this.app.post(`${Server.ROOT_PATH}/witness-request/confirmedEUCitizen/sign`, async (req, res): Promise<void> => {
      await this.sleep();
      const { body } = req;
      console.log(body); // signed claim request
      res.status(200).json({"soon":"it will be here"});
    });

    this.app.listen(8080, '0.0.0.0', (): void => {
      console.log('Listening on 0.0.0.0:8080');
    });
  }

  private async sleep(): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, Server.SLEEP_TIME_SEC * 1000));
  }
}

new Server().start();
