import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { CategoriesEntity } from 'src/db';
import { Repository } from 'typeorm';

@Injectable()
export class CategoriesService {

    constructor(
        @InjectRepository(CategoriesEntity) private readonly categoriesRepository: Repository<CategoriesEntity>
    ) {}


    async findOne(id: number) {
        return this.categoriesRepository.createQueryBuilder('categories')
            .where({ id })
            .getOne();
    }

    async findAll() {
        return this.categoriesRepository.createQueryBuilder('categories')
            .getMany();
    }

    async create(data: Partial<CategoriesEntity>) {
        let category = new CategoriesEntity();        

        category.name = data.name;
        category.description = data.description;
        category.image = data.image;

        return this.categoriesRepository.save(category);
    }

    async update(id: number, data: Partial<CategoriesEntity>) {
        let category = await this.findOne(id);

        category.name = data.name;
        category.description = data.description;
        category.image = data.image;

        return this.categoriesRepository.save(category);
    }

    async delete(id: number) {
        let category = await this.findOne(id);

        await this.categoriesRepository.softDelete(id);

        return category
    }

}
