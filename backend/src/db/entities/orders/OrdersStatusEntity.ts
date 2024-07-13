import { Entity, PrimaryColumn } from "typeorm";




@Entity('orders_status')
export class OrdersStatusEntity {
    @PrimaryColumn({ name: 'code', type: 'varchar', length: 20 }) 
    code: string;
    
    @PrimaryColumn({ name: 'name', type: 'varchar', length: 50 })
    name: string;
}