import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { CategoriesEntity } from 'src/db';
import { Repository } from 'typeorm';

@Injectable()
export class CategoriesService {

    constructor(
        @InjectRepository(CategoriesEntity) private readonly categoriesRepository: Repository<CategoriesEntity>,
    ){}


    async getCategories(){
        return this.categoriesRepository.createQueryBuilder('categories')
        .getMany();
    }

    async getCategory(categoryId: number){
        return this.categoriesRepository.createQueryBuilder('categories')
        .where('categories.id = :categoryId', {categoryId})
        .getOne();
    }

    

}
