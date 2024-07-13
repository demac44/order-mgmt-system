import { Controller, Get, Post, Patch, Delete, Param, Body } from '@nestjs/common';
import { DepartmentsService } from '../services/departments.service';

@Controller('mgmt/departments')
export class DepartmentsController {

    constructor(private readonly departmentsService: DepartmentsService) {}

    @Get(':id')
    async getDepartmentById(@Param('id') id: number) {
        return this.departmentsService.findOne(id);
    }

    @Get()
    async getAllDepartments() {
        return this.departmentsService.findAll();
    }

    @Post()
    async createDepartment(@Body() data: any) {
        return this.departmentsService.create(data);
    }

    @Patch(':id')
    async updateDepartment(@Param('id') id: number, @Body() data: any) {
        return this.departmentsService.update(id, data);
    }

    @Delete(':id')
    async deleteDepartment(@Param('id') id: number) {
        return this.departmentsService.delete(id);
    }
}
