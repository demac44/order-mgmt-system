import { createParamDecorator, ExecutionContext } from '@nestjs/common';

export const SessionStorage = createParamDecorator(
  (data: string, ctx: ExecutionContext) => {
    const request = ctx.switchToHttp().getRequest();

    if (!request.session) return null
    if (!request.session.payload.__private) return null
    return request.session.payload.__private[data];
  },
);
