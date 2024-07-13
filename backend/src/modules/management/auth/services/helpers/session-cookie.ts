
//"{""cookie"":{""originalMaxAge"":6000000,""expires"":""2023-05-18T16:54:31.764Z"",""secure"":false,""httpOnly"":true,""path"":""/"",""sameSite"":true}}"

export interface CookieOptions {
    maxAge?: number | undefined;
    signed?: boolean | undefined;
    expires?: Date | undefined;
    httpOnly?: boolean | undefined;
    path?: string | undefined;
    domain?: string | undefined;
    secure?: boolean | undefined;
    encode?: ((val: string) => string) | undefined;
    sameSite?: boolean | 'lax' | 'strict' | 'none' | undefined;
}

export function makeCookieOptions(options: CookieOptions = {}): CookieOptions {
    return {
        signed: true,
        path: '/',
        sameSite: options.sameSite ? options.sameSite : ['dev', 'prod'].includes(process.env.NODE_ENV) ? 'none' : 'lax',
        secure: ['dev', 'prod'].includes(process.env.NODE_ENV) ? true : false,
        maxAge: (options.maxAge ? options.maxAge : 12000) * 1000,
        expires: new Date(Date.now() + (options.maxAge ? options.maxAge : 12000) * 1000),
        domain: options.domain
    }
}