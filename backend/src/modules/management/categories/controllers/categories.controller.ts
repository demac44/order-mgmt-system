import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { CategoriesService } from '../services/categories.service';

@Controller('mgmt/categories')
export class CategoriesController {


    constructor(private readonly categoriesService: CategoriesService) {}


    @Get()
    async findAll() {
        return this.categoriesService.findAll();
    }

    @Get(':id')
    async findOne(@Param('id') id: number) {
        return this.categoriesService.findOne(id);
    }

    @Post()
    async create(@Body() data: any) {
        return this.categoriesService.create(data);
    }

    @Patch(':id')
    async update(@Param('id') id: number, @Body() data: any) {
        return this.categoriesService.update(id, data);
    }

    @Delete(':id')
    async delete(@Param('id') id: number) {
        return this.categoriesService.delete(id);
    }

}
