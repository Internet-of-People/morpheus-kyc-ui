import express from 'express';
import { Application } from 'express';
import bodyParser from 'body-parser';
import { Md5 } from 'ts-md5/dist/md5';
import confirmedEUCitizenClaimSchema from './confirmedEUCitizenClaimSchema.json';
import confirmedEUCitizenEvidenceSchema from './confirmedEUCitizenEvidenceSchema.json';
import signedWitnessStatement from './signedWitnessStatement.json';
import processes from './processes.json';


class Server {
  private static readonly SLEEP_TIME_SEC: number = 1;
  private app: Application;

  constructor() {
    this.app = express();
    this.app.use(bodyParser.json());
  }

  public start(): void {
    this.app.get('/processes', async (_, res): Promise<void> => {
      console.log('Serving processes...');
      await this.sleep();
      res.status(200).json({processes});
    });

    this.app.get('/blob/:contentId', async (req, res): Promise<void> => {
      const { contentId } = req.params;
      console.log(`Serving blob/${contentId}...`);
      await this.sleep();

      if(contentId == '2582E821B07B1343104254F34FAAD957BA562035D7DAE3ECBC05878A83F1A22B') {
        res.status(200).json(confirmedEUCitizenClaimSchema);
      }
      else if(contentId == '62945E0028EA952E1633ABB1E60C7BAF892F1BEE7F38E74B416D4082F5CEB430') {
        res.status(200).json(confirmedEUCitizenEvidenceSchema);
      }
      else {
        res.status(404);
      }
    });

    this.app.post('/requests', async (req, res): Promise<void> => {
      await this.sleep();
      res.status(202).json(Md5.hashStr(req.body));
    });

    this.app.get('/requests/:capabilityLink/status', async (req, res) => {
      await this.sleep();
      res.status(200).json({
        status: 'APPROVED',
        signedStatement: signedWitnessStatement
      });
    });

    this.app.get('/requests', async (req, res) => {
      await this.sleep();
      res.status(200).json({
        requests: [
          {hashlin: 'HASHLINK1', metadata: {dateOfRequest: 1580736433, status: 'PENDING', process: 'PROCESS_HASHLINK'}},
          {hashlin: 'HASHLINK2', metadata: {dateOfRequest: 1580736133, status: 'APPROVED', process: 'PROCESS_HASHLINK'}}
        ]
      });
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
