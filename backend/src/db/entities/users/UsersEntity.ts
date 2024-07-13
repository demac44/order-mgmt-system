import { Column, Entity, JoinColumn, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { UsersRolesEntity } from "./UsersRolesEntity";



@Entity('users')
export class UsersEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ name: 'username', type: 'varchar', length: 100 })
    username: string;

    @Column({ name: 'password', type: 'varchar', length: 100 })
    password: string;

    @Column({ name: 'email', type: 'varchar', length: 100 })
    email: string;

    @Column({ name: 'first_name', type: 'varchar', length: 100 })
    firstName: string;

    @Column({ name: 'last_name', type: 'varchar', length: 100 })
    lastName: string;

    @Column({ name: 'role_id', type: 'int' })
    roleId: number;

    @OneToOne(() => UsersRolesEntity)
    @JoinColumn({ name: 'role_id', referencedColumnName: 'id'})
    role: UsersRolesEntity;

}