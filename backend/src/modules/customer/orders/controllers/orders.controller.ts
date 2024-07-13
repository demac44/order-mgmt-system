import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { OrdersService } from '../services/orders.service';

@Controller('customer/orders')
export class OrdersController {

    constructor(
        private readonly ordersService: OrdersService
    ){}


    @Post('create')
    createOrder(@Body() data: any){              
        return this.ordersService.createOrder(data);
    }

    @Get(':id')
    getOrder(@Param('id') id: number){        
        return this.ordersService.getOrder(id);
    }

    @Get('table/:tableId')
    getTable(@Param('tableId') code: string){        
        return this.ordersService.getTable(code);
    }

    @Post('cancel/:id')
    cancelOrder(@Param('id') id: number){        
        return this.ordersService.cancelOrder(id);
    }

}
