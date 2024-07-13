import { Injectable, NestMiddleware } from '@nestjs/common';
import { Response } from 'express';
import { UsersSessionsService } from './sessions.service';

@Injectable()
export class UsersSessionsMiddleware implements NestMiddleware {
  private sessionName: string = 'asid'
  private enviroment = process.env.NODE_ENV == 'production' ? 'production' : 'development'

  constructor (
    private readonly sessionService: UsersSessionsService
  ) {}

  async use(req: any, res: Response, next: () => void) {

    let host = req.headers.host

    let origin: string
    if (this.enviroment == 'development') {
      origin = req.headers['dev-request-origin']
    }

    let { setCookie, ...session } = await this.sessionService.session(req.signedCookies[this.sessionName], origin, host)

    req.session = session
    if (setCookie){
        res.cookie(this.sessionName, req.session.id, setCookie)
    }
    next();
  }
}
