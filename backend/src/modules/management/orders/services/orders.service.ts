import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { OrdersEntity } from 'src/db';
import { Repository } from 'typeorm';

@Injectable()
export class OrdersService {

    constructor(
        @InjectRepository(OrdersEntity) private readonly ordersRepository: Repository<OrdersEntity>
    ){}


    async getOrders(status?: string) {        
        let query = this.ordersRepository.createQueryBuilder('orders')
        .leftJoinAndMapMany('orders.items', 'orders.items', 'items')
        .leftJoinAndMapOne('items.menuItem', 'items.menuItem', 'menuItem')
        .orderBy('orders.date_created', 'DESC')
        
        if(status){
            query = query.where('orders.status = :status', {status})
        }        

        return query.getMany()
    }

    async getOrder(orderId: number) {
        let query = this.ordersRepository.createQueryBuilder('orders')
        .leftJoinAndMapMany('orders.items', 'orders.items', 'items')
        .leftJoinAndMapOne('items.menuItem', 'items.menuItem', 'menuItem')
        .where({id: orderId})
        

        return query.getOne()
    }


    async changeStatus(orderId: number, status: string) {        
        let order = await this.getOrder(orderId)

        await this.ordersRepository.update(orderId, {status})

        return this.getOrder(orderId)
    }

}
