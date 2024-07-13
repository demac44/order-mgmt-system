import { Column, Entity, JoinColumn, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { BranchesEntity } from "../branches/BranchesEntity";



@Entity('departments')
export class DepartmentsEntity {
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

    @OneToMany(() => BranchesEntity, branch => branch.department)
    @JoinColumn({ name: 'id', referencedColumnName: 'departmentId' })
    branches: BranchesEntity[];
}