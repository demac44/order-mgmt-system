
import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Observable } from 'rxjs';

@Injectable()
export class ForceExecution implements CanActivate {
  private readonly forceSecret = process.env.FORCE_SECRET
  private readonly environment: 'production' | 'development' = process.env.NODE_ENV == 'production' ? 'production' : 'development'

  canActivate(
    context: ExecutionContext,
  ): boolean | Promise<boolean> | Observable<boolean> {
    const request = context.switchToHttp().getRequest();

    if (this.environment == 'development' || (this.environment == 'production' && request.query['force-secret'] == this.forceSecret)) 
      return true
    else 
      return false
  }
}