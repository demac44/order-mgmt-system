import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { MenuItemsEntity } from "./MenuItemsEntity";



@Entity('menu_items_images')
export class MenuItemsImagesEntity {
    @PrimaryGeneratedColumn()   
    id: number;

    @Column({ name: 'menu_item_id', type: 'int' })
    menuItemId: number;

    @Column({ name: 'image', type: 'varchar', length: 255 })
    image: string;

    @Column({ name: 'is_main', type: 'bool' })
    isMain: boolean;

    @ManyToOne(() => MenuItemsEntity, item => item.images, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'menu_item_id', referencedColumnName: 'id' })
    item: MenuItemsEntity;
}