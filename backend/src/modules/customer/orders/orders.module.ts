import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { OrdersEntity, OrdersItemsEntity, OrdersStatusEntity, TablesEntity } from 'src/db';
import { OrdersService } from './services/orders.service';
import { OrdersController } from './controllers/orders.controller';
import { InvoicesService } from 'src/modules/invoices/services/invoices.service';

@Module({
    controllers: [OrdersController],
    providers: [OrdersService, InvoicesService],
    imports: [
        TypeOrmModule.forFeature([
            OrdersEntity,
            OrdersItemsEntity,
            OrdersStatusEntity,
            TablesEntity
        ])
    ]
})
export class OrdersModule {}
