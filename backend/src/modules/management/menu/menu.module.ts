import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { MenuEntity, MenuItemsEntity, MenuItemsImagesEntity } from 'src/db';
import { MenuController } from './controllers/menu.controller';
import { MenuService } from './services/menu.service';

@Module({
    imports: [
        TypeOrmModule.forFeature([
            MenuEntity,
            MenuItemsEntity,
            MenuItemsImagesEntity
        ])
    ],
    controllers: [MenuController],
    providers: [MenuService],
    exports: []
})
export class MenuModule {}
