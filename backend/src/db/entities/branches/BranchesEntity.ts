import { Column, Entity, JoinColumn, ManyToOne, OneToMany, OneToOne, PrimaryGeneratedColumn, Table } from "typeorm";
import { DepartmentsEntity } from "../departments/DepartmentsEntity";
import { MenuEntity } from "../menu/MenuEntity";
import { OrdersEntity } from "../orders/OrdersEntity";
import { TablesEntity } from "../tables/TablesEntity";



@Entity('branches')
export class BranchesEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ name: 'code', type: 'varchar', length: 10 })
    code: string;

    @Column({ name: 'address_country_name', type: 'varchar', length: 100 })
    addressCountryName: string;

    @Column({ name: 'address_country_code', type: 'varchar', length: 10 })
    addressCountryCode: string;

    @Column({ name: 'address_city', type: 'varchar', length: 100 })
    addressCity: string;

    @Column({ name: 'address_street', type: 'varchar', length: 100 })
    addressStreet: string;

    @Column({ name: 'address_postal_code', type: 'varchar', length: 10 })
    addressPostalCode: string;

    @Column({ name: 'department_id', type: 'int' })
    departmentId: number;

    @ManyToOne(() => DepartmentsEntity, department => department.branches)
    @JoinColumn({ name: 'department_id', referencedColumnName: 'id' })
    department: DepartmentsEntity;

    @OneToMany(() => MenuEntity, menu => menu.branch)
    @JoinColumn({ name: 'id', referencedColumnName: 'branchId' })
    menu: MenuEntity

    @OneToMany(() => TablesEntity, table => table.branch)
    @JoinColumn({ name: 'id', referencedColumnName: 'branchId' })
    tables: TablesEntity[];

}