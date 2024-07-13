import { Column, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn, Table } from "typeorm";
import { OrdersStatusEntity } from "./OrdersStatusEntity";
import { BranchesEntity } from "../branches/BranchesEntity";
import { TablesEntity } from "../tables/TablesEntity";
import { OrdersItemsEntity } from "./OrdersItemsEntity";



@Entity('orders')
export class OrdersEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ name: 'order_number', type: 'varchar', length: 10 })
    orderNumber: string;

    @Column({ name: 'date', type: 'timestamp', default: () => 'CURRENT_TIMESTAMP'})
    date: Date;

    @Column({ name: 'status', type: 'varchar', length: 20 })
    status: string;

    @Column({ name: 'total', type: 'decimal', precision: 10, scale: 2 })
    total: number;

    @ManyToOne(() => OrdersStatusEntity, status => status.code)
    orderStatus: OrdersStatusEntity;

    @Column({ name: 'table_id', type: 'varchar' })
    tableId: string;

    @ManyToOne(() => TablesEntity, table => table.orders)
    @JoinColumn({ name: 'table_id', referencedColumnName: 'code' })
    table: TablesEntity;

    @OneToMany(() => OrdersItemsEntity, items => items.order)
    @JoinColumn({ name: 'order_id', referencedColumnName: 'id' })
    items: OrdersItemsEntity[];

    @Column({ name: 'date_created', type: 'timestamp', default: () => 'CURRENT_TIMESTAMP'})
    dateCreated: string;

    @Column({ name: 'payment_method', type: 'varchar', length: 20 })
    paymentMethod: 'cash' | 'card';

    @Column({ name: 'payment_info', type: 'json', nullable: true })
    paymentInfo: any;

    @Column({ name: 'invoice', type: 'varchar', length: 255, nullable: true })
    invoice: string;
}