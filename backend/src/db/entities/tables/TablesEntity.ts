import { Column, DeleteDateColumn, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { BranchesEntity } from "../branches/BranchesEntity";
import { OrdersEntity } from "../orders/OrdersEntity";




@Entity('tables')
export class TablesEntity {
    @PrimaryGeneratedColumn()
    id: number;
    
    @Column({ name: 'code', type: 'varchar', length: 10, unique: true })
    code: string;

    @Column({ name: 'branch_id', type: 'int' })
    branchId: number;

    @ManyToOne(() => BranchesEntity, branch => branch.tables)
    @JoinColumn({ name: 'branch_id', referencedColumnName: 'id' })
    branch: BranchesEntity;

    @OneToMany(() => OrdersEntity, order => order.table)
    @JoinColumn({ name: 'id', referencedColumnName: 'table_id' })
    orders: OrdersEntity[];

    @DeleteDateColumn({ name: 'deleted_at' })
    deletedAt: Date;
}