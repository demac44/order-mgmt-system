import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { MenuEntity, MenuItemsEntity, MenuItemsImagesEntity } from 'src/db';
import { Repository } from 'typeorm';

@Injectable()
export class MenuService {

    constructor(
        @InjectRepository(MenuEntity) private readonly menuRepository: Repository<MenuEntity>,
        @InjectRepository(MenuItemsEntity) private readonly menuItemsRepository: Repository<MenuItemsEntity>,
        @InjectRepository(MenuItemsImagesEntity) private readonly menuItemsImagesRepository: Repository<MenuItemsImagesEntity>,
    ) {}


    async getMenuById(id: number){
        let query = this.menuRepository.createQueryBuilder('menu')
        .leftJoinAndMapMany('menu.items', 'menu.items', 'items')
        .leftJoinAndMapMany('items.images', 'items.images', 'images')
        .leftJoinAndMapOne('items.category', 'items.category', 'category')
        .where('menu.id = :id', {id})

        return query.getOne();
    }

    async getMenuByBranchId(branchId: number){
        let query = this.menuRepository.createQueryBuilder('menu')
        .leftJoinAndMapMany('menu.items', 'menu.items', 'items')
        .leftJoinAndMapMany('items.images', 'items.images', 'images')
        .leftJoinAndMapOne('items.category', 'items.category', 'category')
        .where('menu.branchId = :branchId', {branchId})

        return query.getOne();
    }

    async getMenusByBranchId(branchId: number){
        let query = this.menuRepository.createQueryBuilder('menu')
        .leftJoinAndMapMany('menu.items', 'menu.items', 'items')
        .leftJoinAndMapMany('items.images', 'items.images', 'images')
        .leftJoinAndMapOne('items.category', 'items.category', 'category')
        .where('menu.branchId = :branchId', {branchId})

        return query.getMany();
    }


    async create(data: Partial<MenuEntity>){
        let menu = new MenuEntity();

        menu.branchId = data.branchId;
        menu.description = data.description;
        menu.name = data.name;

        return this.menuRepository.save(menu);
    }

    async deleteMenu(id: number){
        let menu = await this.getMenuById(id);
        await this.menuRepository.softDelete(id);
        return menu;
    }

    async addItem(data: { images: any } & Partial<MenuItemsEntity>){
            
        let item = new MenuItemsEntity();

        item.menuId = data.menuId;
        item.name = data.name;
        item.price = data.price;
        item.description = data.description;
        item.categoryId = data.categoryId;
        item.quantity = data.quantity;
        item.isSide = data.isSide;

        item = await this.menuItemsRepository.save(item);

        if(data.images){
            for(let image of JSON.parse(data.images)){
                let img = new MenuItemsImagesEntity();
                img.image = image.image;
                img.menuItemId = item.id;
                img.isMain = image.isMain;

                await this.menuItemsImagesRepository.save(img);
            }
        }

        return item;
    }

    async getItem(id: number){
        let query = this.menuItemsRepository.createQueryBuilder('item')
        .leftJoinAndMapMany('item.images', 'item.images', 'images')
        .leftJoinAndMapOne('item.category', 'item.category', 'category')
        .where('item.id = :id', {id})

        return query.getOne();
    }

    async deleteItem(id: number){
        let item = await this.getItem(id);
        await this.menuItemsRepository.softDelete(id);
        return item;
    }


    async updateItem(id: number, data: Partial<MenuItemsEntity> & { images: any }){
        let item = await this.getItem(id);

        console.log(data.price);
        
        item.name = data.name;
        item.price = data.price;
        item.description = data.description;
        item.categoryId = data.categoryId;
        item.quantity = data.quantity;
        item.isSide = data.isSide;

        item = await this.menuItemsRepository.save(item);

        if(data.images){
            for(let image of JSON.parse(data.images)){
                let img = new MenuItemsImagesEntity();
                img.id = image.id;
                img.image = image.image;
                img.menuItemId = item.id;
                img.isMain = image.isMain;

                await this.menuItemsImagesRepository.save(img);
            }
        }

        return item;
    }

    async deleteImage(id: number){
        let image = await this.menuItemsImagesRepository.createQueryBuilder().where({id}).getOne();
        await this.menuItemsImagesRepository.delete(id);
        return image;
    }




}
