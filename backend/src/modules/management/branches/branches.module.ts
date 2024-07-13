import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { BranchesEntity } from 'src/db';
import { BranchesController } from './controllers/branches.controller';
import { BranchesService } from './services/branches.service';

@Module({
    imports: [
        TypeOrmModule.forFeature([
            BranchesEntity
        ])
    ],
    controllers: [BranchesController],
    providers: [BranchesService],
    exports: []
})
export class BranchesModule {}
