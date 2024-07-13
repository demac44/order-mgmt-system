import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";




@Entity('users_roles')
export class UsersRolesEntity {
    @PrimaryGeneratedColumn({ name: 'id', type: 'int' })
    id: number;

    @Column({ name: 'code', type: 'varchar', length: 50 })
    code: string;

    @Column({ name: 'name', type: 'varchar', length: 100 })
    name: string;

    @Column({ name: 'description', type: 'varchar', length: 255 })
    description: string;
}