import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CategoriesEntity, MenuEntity, MenuItemsEntity, MenuItemsImagesEntity } from 'src/db';
import { MenuService } from './services/menu.service';
import { CategoriesService } from './services/categories.service';
import { MenuController } from './controllers/menu.controller';
import { CategoriesController } from './controllers/categories.controller';

@Module({
    imports: [
        TypeOrmModule.forFeature([
            MenuEntity,
            MenuItemsEntity,
            CategoriesEntity,
            MenuItemsImagesEntity
        ])
    ],
    controllers: [MenuController, CategoriesController],
    providers: [MenuService, CategoriesService],
})
export class MenuModule {}
