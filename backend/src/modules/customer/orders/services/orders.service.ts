import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { OrdersEntity, OrdersItemsEntity, OrdersStatusEntity, TablesEntity } from 'src/db';
import { InvoicesService } from 'src/modules/invoices/services/invoices.service';
import { Repository } from 'typeorm';

@Injectable()
export class OrdersService {


    constructor(
        @InjectRepository(OrdersEntity) private readonly ordersRepository: Repository<OrdersEntity>,
        @InjectRepository(OrdersStatusEntity) private readonly orderStatusRepository: Repository<OrdersStatusEntity>,
        @InjectRepository(OrdersItemsEntity) private readonly orderItemsRepository: Repository<OrdersItemsEntity>,
        @InjectRepository(TablesEntity) private readonly tablesRepository: Repository<TablesEntity>,
        private readonly invoicesService: InvoicesService
    ) {}


    async getOrder(id: number){
        let query = this.ordersRepository.createQueryBuilder('orders')
        .leftJoinAndSelect('orders.items', 'items')
        .where('orders.id = :id', { id })
        
        return query.getOne()
    }

    async getTable(code: string){
        let table = this.tablesRepository.createQueryBuilder('table')
        .where({ code: code.trim() })
        .getOne()

        // if(!table) throw Error('Wrong table number!')
        
        return table
    }


    async createOrder(data: any){      
        // const table = await this.getTable(data.tableId);

        data.items = JSON.parse(data.items);    
        
        let order = new OrdersEntity();

        let total = 0;

        for(let item of data.items){
            total += item.price * item.quantity;
        }

        order.orderNumber = this.createOrderNumber();
        order.status = 'open';
        order.total = total;
        order.tableId = data.tableId.trim().toUpperCase();
        order.paymentInfo = data.paymentInfo;
        order.paymentMethod = data.paymentMethod;

        order = await this.ordersRepository.save(order);

        let items = await this.createOrderItems({ items: data.items, orderId: order.id });

        let invoiceData = {
            "orderNumber": order.orderNumber,
            "orderDate": new Date(order.dateCreated).toLocaleString('de-de'),
            "items": items.map(item => {
                return {
                    name: item.menuItem.name,
                    price: item.menuItem.price,
                    quantity: item.quantity,
                    total: item.total_price
                }
            }),
            "total": order.total.toFixed(2),
        }
        let pdfBuffer = await this.invoicesService.generator(this.content, invoiceData, null, true, 'pdf_buffer')

        let invoice = await this.invoicesService.uploadFile(pdfBuffer, 'invoices')  
        
        await this.ordersRepository.update(order.id, { invoice: invoice.secure_url })

        return { order, items, invoice: invoice.secure_url } 
    }


    async createOrderItems(data: { items: any[], orderId: number }){

        let items = [];

        for(let item of data.items){
            let newItem = new OrdersItemsEntity();

            newItem.orderId = data.orderId;
            newItem.quantity = item.quantity;
            newItem.itemId = item.productId;
            newItem.total_price = parseFloat(item.price.toString()) * parseFloat(item.quantity.toString());
            newItem.discount = 0;

            let saved = await this.orderItemsRepository.save(newItem)

            let joinedItem = await this.orderItemsRepository.createQueryBuilder('item')
            .leftJoinAndMapOne('item.menuItem', 'item.menuItem', 'menuItem')
            .where({ id: saved.id })
            .getOne()

            items.push(joinedItem)
        }


        return items;
    }

    createOrderNumber(){
        return Math.random().toString(36).substr(2, 9).toUpperCase();
    }


    async cancelOrder(id: number){
        let order = await this.getOrder(id);

        await this.ordersRepository.update(id, { status: 'cancelled' });

        return await this.getOrder(id);
    }

    
    private content: string =  `
    <!DOCTYPE html>
    <html lang="en">
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice</title>
    </head>
    <body>
        <h1>Invoice # {{orderNumber}}</h1>
        <h3>Order date: {{orderDate}}</h3>


        <div style="">
            <h3>Order items:</h3>
            {{#items}}
            <div style="border: 1px solid black; padding: 20px;">
                <h4>{{name}}</h4>
                <p>Price: JOD {{price}}</p>
                <p>Quantity: {{quantity}}</p>
                <p>Total: JOD {{total}}</p>
            </div>
            {{/items}}
        </div>

        <h3>Total: JOD {{total}}</h3>
    </body>
    </html>`

}
