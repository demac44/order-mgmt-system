import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { OrdersEntity } from "./OrdersEntity";
import { MenuItemsEntity } from "../menu/MenuItemsEntity";



@Entity('orders_items')
export class OrdersItemsEntity {
    @PrimaryGeneratedColumn()
    id: number;
    
    @Column({ name: 'order_id', type: 'int' })
    orderId: number;

    @Column({ name: 'item_id', type: 'int' })
    itemId: number;

    @Column({ name: 'quantity', type: 'int' })
    quantity: number;

    @Column({ name: 'total_price', type: 'decimal', precision: 10, scale: 2 })
    total_price: number;

    @Column({ name: 'discount', type: 'decimal', precision: 10, scale: 2 })
    discount: number;

    @ManyToOne(() => OrdersEntity, order => order.items, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'order_id', referencedColumnName: 'id' })   
    order: OrdersEntity;

    @ManyToOne(() => MenuItemsEntity, { onDelete: 'RESTRICT' })
    @JoinColumn({ name: 'item_id', referencedColumnName: 'id' })
    menuItem: MenuItemsEntity;
}