import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { MenuService } from '../services/menu.service';

@Controller('mgmt/menu')
export class MenuController {

    constructor(private readonly menuService: MenuService) {}


    @Get(':id')
    async getMenuById(@Param('id') id: number){
        return this.menuService.getMenuById(id);
    }

    @Get('branch/:branchId')
    async getMenuByBranchId(@Param('branchId') branchId: number){
        return this.menuService.getMenuByBranchId(branchId);
    }


    @Get('branch/:branchId/all')
    async getMenusByBranchId(@Param('branchId') branchId: number){
        return this.menuService.getMenusByBranchId(branchId);
    }

    @Post()
    async create(@Body() data: any){
        return this.menuService.create(data);
    }

    @Delete(':id')
    async delete(@Param('id') id: number){
        return this.menuService.deleteMenu(id);
    }

    @Post('item')
    async addItem(@Body() data: any){        
        return this.menuService.addItem(data);
    }

    @Delete('item/:id')
    async deleteItem(@Param('id') id: number){
        return this.menuService.deleteItem(id);
    }

    @Patch('item/:id')
    async updateItem(@Param('id') id: number, @Body() data: any){
        return this.menuService.updateItem(id, data);
    }

    @Delete('item/image/:id')   
    async deleteItemImage(@Param('id') id: number){
        return this.menuService.deleteImage(id);
    }
}
