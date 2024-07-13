import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CategoriesEntity } from 'src/db';
import { CategoriesController } from './controllers/categories.controller';
import { CategoriesService } from './services/categories.service';

@Module({
    imports: [
        TypeOrmModule.forFeature([
            CategoriesEntity
        ])
    ],
    controllers: [CategoriesController],
    providers: [CategoriesService],
    exports: []
})
export class CategoriesModule {}
