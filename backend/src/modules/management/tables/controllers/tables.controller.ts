import { Body, Controller, DefaultValuePipe, Delete, Get, Param, Patch, Post, Query } from '@nestjs/common';
import { TablesService } from '../services/tables.service';

@Controller('mgmt/tables')
export class TablesController {

    constructor(
        private readonly tablesService: TablesService
    ) {}


    @Get(':id')
    async getOne(id: number) {
        return this.tablesService.getOne(id);
    }

    @Get()
    async getAll(
        @Query('branchId') branchId: number,
        @Query('joinOrders', new DefaultValuePipe(false)) joinOrders: boolean,
        @Query('withOrders', new DefaultValuePipe(false)) withOrders: boolean
    ) {
        return this.tablesService.getAll(branchId, { joinOrders, withOrders });
    }

    @Patch(':id')
    async update(@Param('id') id: number, @Body() data: { code: string }) {
        return this.tablesService.update(id, data);
    }

    @Delete(':id')
    async delete(@Param('id') id: number) {
        return this.tablesService.delete(id);
    }

    @Post()
    async create(@Body() data: { code: string, branchId: number }) {
        return this.tablesService.create(data);
    }

}
