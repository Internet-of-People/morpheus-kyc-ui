import express from 'express';
import { Application } from 'express';
import confirmedEUCitizenClaimSchema from './confirmedEUCitizenClaimSchema.json';
import confirmedEUCitizenEvidenceSchema from './confirmedEUCitizenEvidenceSchema.json';
import processes from './processes.json';

class Server {
  private static readonly SLEEP_TIME_SEC: number = 2;
  private app: Application;

  constructor() {
    this.app = express();
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

    // TODO: sending in witness request
    // this.app.post(/requests) -> CAPABILITY_LINK
    // this.app.get(/requests/CAPABILITY_LINK/status) -> status (pending/approved/denied - contains signed witness request)

    this.app.listen(8080, '0.0.0.0', (): void => {
      console.log('Listening on 0.0.0.0:8080');
    });
  }

  private async sleep(): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, Server.SLEEP_TIME_SEC * 1000));
  }
}

new Server().start();
