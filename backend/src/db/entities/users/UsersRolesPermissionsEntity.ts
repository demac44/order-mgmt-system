import { Entity, JoinColumn, OneToMany, PrimaryColumn } from "typeorm";
import { UsersRolesEntity } from "./UsersRolesEntity";
import { UsersPermissionsEntity } from "./UsersPermissionsEntity";



@Entity('users_roles_permissions')
export class UsersRolesPermissionsEntity {
    @PrimaryColumn({ name: 'role_id', type: 'int' })
    roleId: number;
    
    @PrimaryColumn({ name: 'permission_id', type: 'int' })
    permissionId: number;

    @OneToMany(() => UsersRolesEntity, role => role.id)
    @JoinColumn({ name: 'role_id', referencedColumnName: 'id' })
    role: UsersRolesEntity;

    @OneToMany(() => UsersPermissionsEntity, permission => permission.id)
    @JoinColumn({ name: 'permission_id', referencedColumnName: 'id' })
    permission: UsersPermissionsEntity;
}