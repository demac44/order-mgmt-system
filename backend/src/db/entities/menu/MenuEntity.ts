import { Column, DeleteDateColumn, Entity, JoinColumn, ManyToOne, OneToMany, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { BranchesEntity } from "../branches/BranchesEntity";
import { MenuItemsEntity } from "./MenuItemsEntity";



@Entity('menu')
export class MenuEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ name: 'name', type: 'varchar', length: 100 })
    name: string;

    @Column({ name: 'description', type: 'text' })
    description: string;

    @Column({ name: 'branch_id', type: 'int' })
    branchId: number;

    @ManyToOne(() => BranchesEntity, branch => branch.menu)
    @JoinColumn({ name: 'branch_id', referencedColumnName: 'id' })
    branch: BranchesEntity;

    @OneToMany(() => MenuItemsEntity, item => item.menu)
    @JoinColumn({ name: 'id', referencedColumnName: 'menuId' })
    items: MenuItemsEntity[];

    @DeleteDateColumn({ name: 'deleted_at' })   
    deletedAt: Date;

}