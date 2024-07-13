import { Column, DeleteDateColumn, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { MenuItemsEntity } from "./MenuItemsEntity";




@Entity('categories')
export class CategoriesEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ name: 'name', type: 'varchar', length: 100 })
    name: string;

    @Column({ name: 'description', type: 'varchar', length: 255 })
    description: string;

    @Column({ name: 'image', type: 'varchar', length: 255 })
    image: string;

    @Column({ name: 'parent_id', type: 'int', nullable: true})
    parentId: number; 

    @OneToMany(() => CategoriesEntity, category => category.parent)
    children: CategoriesEntity[];

    @OneToMany(() => CategoriesEntity, category => category.children)
    parent: CategoriesEntity;

    @OneToMany(() => MenuItemsEntity, item => item.category)
    items: MenuItemsEntity[];

    @DeleteDateColumn({ name: 'deleted_at' })
    deletedAt: Date;

}