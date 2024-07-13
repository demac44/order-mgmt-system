import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DepartmentsEntity } from 'src/db';
import { DepartmentsController } from './controllers/departments.controller';
import { DepartmentsService } from './services/departments.service';

@Module({
    imports: [
        TypeOrmModule.forFeature([
            DepartmentsEntity
        ])
    ],
    controllers: [DepartmentsController],
    providers: [DepartmentsService]
})
export class DepartmentsModule {}
