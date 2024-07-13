import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { makeId } from 'src/common/helpers/make-id';
import { IsNull, LessThan, Not, Repository } from 'typeorm';
import { CookieOptions, makeCookieOptions } from './helpers/session-cookie';
import { UsersSessionsEntity } from 'src/db';

export interface UsersSession extends UsersSessionsEntity {
    type: 'admin-session'
    setCookie?: CookieOptions
}

@Injectable()
export class UsersSessionsService {
    private secret = process.env.SESSION_SECRET;
    private expire = parseInt(process.env.SESSION_EXPIRE) * 1000;
    private SERVICE_DEPLOYED = process.env.SERVICE_DEPLOYED == 'true' ? true : false
    private ENVIRONMENT = process.env.NODE_ENV == 'production' ? 'production' : 'development'

    constructor (
        @InjectRepository(UsersSessionsEntity) private readonly sessionRepository: Repository<UsersSessionsEntity>
    ) {}

    async generate({ origin, host }): Promise<any> {
        let cookie = makeCookieOptions({
            maxAge: isNaN(this.expire) ? 12000 : this.expire,
            domain: this.domain(origin, host),
            sameSite: this.sameSite(origin) 
        })
        let newSession = new UsersSessionsEntity()
        newSession.id = makeId(50)
        newSession.payload = { cookie }
        newSession.expiredAt = cookie.maxAge + Date.now()

        let session = await this.sessionRepository.save(newSession)
        return {
            ...session,
            setCookie: session.payload.cookie
        }
    }

    async session(sessionId: string, origin?: string, host?: string): Promise<UsersSession> {
        let session = await this.sessionRepository.createQueryBuilder('session')
            .leftJoinAndMapOne('session.user','session.user','user')
            .where({ id: sessionId })
            .andWhere('expired_at > :timestamp', { timestamp: Date.now() })
            .getOne()

        if (!session) session = await this.generate({ origin, host })

        this.clean()
        this.destroy()

        return { ...session, type: 'admin-session' }
    }

    private clean() {
        this.sessionRepository.update({expiredAt: LessThan(Date.now())}, { destroyedAt: Date.now() })
    }

    private destroy() {
        this.sessionRepository.delete({ destroyedAt: Not(IsNull()) })
    }

    private domain(origin?: string, host?: string): string | null {
        let domain = null as string | null

        if (this.SERVICE_DEPLOYED) {
            if (this.ENVIRONMENT == 'development') {
                if (origin == 'localhost') domain = null
                else domain = 'egotton.com'
            } else {
                domain = 'egotton.com'
            }
        }  

        return domain
    }

    private sameSite(origin?: string): 'none' | 'lax' {
        if (origin == 'localhost') return 'none'
        else return 'lax'
    }
}
