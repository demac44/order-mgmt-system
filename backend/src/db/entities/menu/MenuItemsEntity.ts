import { Column, DeleteDateColumn, Entity, JoinColumn, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { MenuEntity } from "./MenuEntity";
import { CategoriesEntity } from "./CategoriesEntity";
import { MenuItemsImagesEntity } from "./MenuItemsImagesEntity";




@Entity('menu_items')
export class MenuItemsEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ name: 'name', type: 'varchar', length: 100 })
    name: string;

    @Column({ name: 'description', type: 'text' })
    description: string;

    @Column({ name: 'price', type: 'decimal', precision: 10, scale: 2 })
    price: number;

    @Column({ name: 'category_id', type: 'int' })
    categoryId: number;

    @Column({ name: 'menu_id', type: 'int' })
    menuId: number;

    @Column({ name: 'quantity', type: 'int', default: 0})
    quantity: number;

    @Column({ name: 'is_side', type: 'boolean', default: false })
    isSide: boolean;

    @ManyToOne(() => MenuEntity, menu => menu.items, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'menu_id', referencedColumnName: 'id' })
    menu: MenuEntity;

    @ManyToOne(() => CategoriesEntity, category => category.items, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'category_id', referencedColumnName: 'id' })
    category: CategoriesEntity;

    @OneToMany(() => MenuItemsImagesEntity, image => image.item, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'id', referencedColumnName: 'menu_item_id' })
    images: MenuItemsImagesEntity[];

    @DeleteDateColumn({ name: 'deleted_at' })
    deletedAt: Date;
}