import { Module } from '@nestjs/common';
import { MenuModule } from './menu/menu.module';
import { OrdersModule } from './orders/orders.module';

@Module({
    imports: [
        MenuModule, 
        OrdersModule
    ],
    controllers: [],
    providers: [],
    exports: [MenuModule, OrdersModule]
})
export class CustomersModule {}
