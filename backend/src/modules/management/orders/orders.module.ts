import { Module } from '@nestjs/common';
import { OrdersController } from './controllers/orders.controller';
import { OrdersService } from './services/orders.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { OrdersEntity } from 'src/db';

@Module({
    imports: [
        TypeOrmModule.forFeature([
            OrdersEntity
        ]),
    ],
    exports: [],
    providers: [OrdersService],
    controllers: [OrdersController]
})
export class OrdersModule {}
