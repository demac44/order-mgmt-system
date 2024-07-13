import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { MenuEntity, MenuItemsEntity } from 'src/db';
import { Repository } from 'typeorm';

@Injectable()
export class MenuService {

    constructor(
        @InjectRepository(MenuEntity) private readonly menuRepository: Repository<MenuEntity>,
        @InjectRepository(MenuItemsEntity) private readonly menuItemsRepository: Repository<MenuItemsEntity>,
    ){}


    async getMenu(branchId: number){
        return await this.menuRepository.createQueryBuilder('menu')
            .leftJoinAndMapMany('menu.items', 'menu.items', 'items')
            .leftJoinAndMapMany('items.images', 'items.images', 'images')
            .where('menu.branchId = :branchId', {branchId})
            .getOne();
    }

    async getMenus(branchId: number){
        return await this.menuRepository.createQueryBuilder('menu')
            .leftJoinAndMapMany('menu.items', 'menu.items', 'items')
            .leftJoinAndMapMany('items.images', 'items.images', 'images')
            .where('menu.branchId = :branchId', {branchId})
            .getMany();
    }

    async getPopularItems(branchId: number){
        let query = this.menuItemsRepository.createQueryBuilder('items')
        .leftJoinAndMapOne('items.menu', 'items.menu', 'menu')
        .leftJoinAndMapMany('items.images', 'items.images', 'images')
        .where('menu.branchId = :branchId', {branchId})
        .andWhere('items.isSide = false')
        .limit(10)
        
        return await query.getMany();
    }

    async getMenuItem(itemId: number){
        return await this.menuItemsRepository.createQueryBuilder('items')
            .leftJoinAndMapOne('items.menu', 'items.menu', 'menu')
            .leftJoinAndMapMany('items.images', 'items.images', 'images')
            .where('items.id = :itemId', {itemId})
            .getOne();
    }

    async getMenuItems(branchId: number, filters: { categoryId?: number, search?: string, isSide?: boolean}){        
        let query = this.menuItemsRepository.createQueryBuilder('items')
            .leftJoinAndMapOne('items.menu', 'items.menu', 'menu')
            .leftJoinAndMapMany('items.images', 'items.images', 'images')
            .where('menu.branchId = :branchId', {branchId})

        if(filters.isSide){
            query.andWhere('items.isSide = :isSide', {isSide: true})
        }
        
        if(filters.categoryId){
            query.andWhere('items.categoryId = :categoryId', {categoryId: filters.categoryId})
        }

        if(filters.search && filters?.search?.length > 0){
            query.andWhere('UPPER(items.name) LIKE :search', {search: `%${filters.search.toUpperCase()}%`})
        }


        return await query.getMany();
    }

}
