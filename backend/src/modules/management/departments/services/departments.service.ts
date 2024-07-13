import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DepartmentsEntity } from 'src/db';
import { Repository, DeleteResult } from 'typeorm';

@Injectable()
export class DepartmentsService {
    constructor(
        @InjectRepository(DepartmentsEntity)
        private readonly departmentsRepository: Repository<DepartmentsEntity>,
    ) {}

    async findOne(id: number): Promise<DepartmentsEntity | undefined> {
        return this.departmentsRepository.createQueryBuilder('departments')
            .where('departments.id = :id', { id })
            .getOne();
    }

    async findAll(): Promise<DepartmentsEntity[]> {
        return this.departmentsRepository.createQueryBuilder('departments')
            .getMany();
    }

    async create(departmentData: Partial<DepartmentsEntity>): Promise<DepartmentsEntity> {
        let department = new DepartmentsEntity();

        department.addressCity = departmentData.addressCity;
        department.addressCountryCode = departmentData.addressCountryCode;
        department.addressPostalCode = departmentData.addressPostalCode;
        department.addressStreet = departmentData.addressStreet;
        department.code = departmentData.code;
        department.addressCountryName = departmentData.addressCountryName;

        return this.departmentsRepository.save(department);
    }

    async delete(id: number): Promise<DeleteResult> {
        let department = await this.findOne(id);

        if (!department) {
            throw new Error('Department not found');
        }
        return this.departmentsRepository.delete(id);
    }

    async update(id: number, departmentData: Partial<DepartmentsEntity>): Promise<DepartmentsEntity | undefined> {
        let department = await this.findOne(id);

        department.addressCity = departmentData.addressCity;
        department.addressCountryCode = departmentData.addressCountryCode;
        department.addressPostalCode = departmentData.addressPostalCode;
        department.addressStreet = departmentData.addressStreet;
        department.code = departmentData.code;
        department.addressCountryName = departmentData.addressCountryName;

        return this.departmentsRepository.save({ id, department });
    }
}
