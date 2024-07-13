import 'reflect-metadata'

export function WithoutInterceptors(...args: any[]) {
    return function(target, key, descriptor) {
        Reflect.defineMetadata('__interceptors_skip__', args.map(arg => arg.name), descriptor.value)
    }
}