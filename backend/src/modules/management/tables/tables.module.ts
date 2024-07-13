import { Module } from '@nestjs/common';
import { TablesController } from './controllers/tables.controller';
import { TablesService } from './services/tables.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TablesEntity } from 'src/db';

@Module({
    imports: [
        TypeOrmModule.forFeature([
            TablesEntity
        ]),
    ],
    controllers: [TablesController],
    providers: [TablesService],
})
export class TablesModule {}
