import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { BranchesService } from '../services/branches.service';

@Controller('mgmt/branches')
export class BranchesController {

    constructor(
        private readonly branchesService: BranchesService
    ) {}


    @Get(':id')
    async getOne(@Param() id: number) {
        return this.branchesService.findOne(id);
    }

    @Get()
    async getAll() {
        return this.branchesService.findAll();
    }

    @Patch(':id')
    async update(id: number, @Body() data: any){
        return this.branchesService.update(id, data);
    }

    @Delete(':id')
    async delete(@Param('id') id: number) {
        return this.branchesService.delete(id);
    }

    @Post()
    async create(@Body() data: any) {
        return this.branchesService.create(data);
    }

}
