
import { createParamDecorator, ExecutionContext } from '@nestjs/common';

export const ExcludeInterceptors = (...interceptors) => {
    return function (target, propertyKey, descriptor){
      console.log(target, propertyKey, descriptor)
      console.log(Reflect.getMetadata("__interceptors__", target))
    }
};