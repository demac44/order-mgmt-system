import { Controller, DefaultValuePipe, Get, Param, Query } from '@nestjs/common';
import { MenuService } from '../services/menu.service';

@Controller('customer/menu')
export class MenuController {

    constructor(
        private readonly menuService: MenuService
    ){}


    @Get(':branchId')
    async getMenu(@Param('branchId') branchId: number){
        return await this.menuService.getMenu(branchId);
    }

    @Get('all/:branchId')
    async getMenus(@Param('branchId') branchId: number){
        return await this.menuService.getMenus(branchId);
    }

    @Get('popular/:branchId')
    async getPopularItems(@Param('branchId') branchId: number){
        return await this.menuService.getPopularItems(branchId);
    }

    @Get('item/:itemId')
    async getMenuItem(@Param('itemId') itemId: number){
        return await this.menuService.getMenuItem(itemId);
    }

    @Get('items/:branchId')
    async getMenuItems(
        @Param('branchId') branchId: number,
        @Query('category') category: number,
        @Query('isSide') isSide: boolean,
        @Query('search', new DefaultValuePipe('')) search: string
    ){
        console.log(isSide);
        
        return await this.menuService.getMenuItems(branchId, { categoryId: category, search, isSide });
    }



}
