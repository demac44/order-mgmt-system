import { Controller, Get, Param, Query } from '@nestjs/common';
import { OrdersService } from '../services/orders.service';

@Controller('mgmt/orders')
export class OrdersController {

    constructor(
        private readonly ordersService: OrdersService
    ){}


    @Get()
    async getOrders(
        @Query('status') status: string
    ) {
        return this.ordersService.getOrders(status)
    }

    @Get('update-status/:orderId/:status')
    async changeStatus(
        @Param('status') status: string,
        @Param('orderId') orderId: number
    ) {
        return this.ordersService.changeStatus(orderId, status)
    }
}
