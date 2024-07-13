import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersSessionsEntity, entities } from './db';
import { ConfigModule } from '@nestjs/config';
import { ManagementModule } from './modules/management/management.module';
import { UsersSessionsMiddleware } from './modules/management/auth/services/sessions-middleware.service';
import { UsersSessionsService } from './modules/management/auth/services/sessions.service';
import { CustomersModule } from './modules/customer/customers.module';
import { InvoicesModule } from './modules/invoices/invoices.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    TypeOrmModule.forFeature([UsersSessionsEntity]),
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.DB_HOST,
      port: process.env.DB_HOST ? parseInt(process.env.DB_PORT) : 5432,
      database: process.env.DB_DATABASE,
      username: process.env.DB_USERNAME,
      password: process.env.DB_PASSWORD,
      entities: entities,
      synchronize: true,
      ssl: process.env.NODE_ENV === 'production' ? {
        rejectUnauthorized: false
      } : false
    }),  
    // MODULES
    ManagementModule,
    CustomersModule,
    InvoicesModule
  ],
  controllers: [AppController],
  providers: [AppService, UsersSessionsService],
})
export class AppModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(UsersSessionsMiddleware).forRoutes({ path: '/mgmt*', method: RequestMethod.ALL })
  }
}
