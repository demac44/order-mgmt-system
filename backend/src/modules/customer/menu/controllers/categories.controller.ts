import { Controller, Get } from '@nestjs/common';
import { CategoriesService } from '../services/categories.service';

@Controller('customer/categories')
export class CategoriesController {

    constructor(
        private readonly categoriesService: CategoriesService,
    ){}

    @Get()
    async getCategories(){
        return this.categoriesService.getCategories();
    }

    @Get(':categoryId')
    async getCategory(categoryId: number){
        return this.categoriesService.getCategory(categoryId);
    }

}
