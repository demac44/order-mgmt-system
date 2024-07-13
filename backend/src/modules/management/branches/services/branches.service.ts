import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { BranchesEntity } from 'src/db';
import { Repository } from 'typeorm';

@Injectable()
export class BranchesService {

    constructor(
        @InjectRepository(BranchesEntity) private readonly branchesRepository: Repository<BranchesEntity>
    ) {}


    async findOne(id: number) {
        return this.branchesRepository.createQueryBuilder('branches')
            .where('branches.id = :id', { id })
            .getOne();
    }

    async findAll() {
        return this.branchesRepository.createQueryBuilder('branches')
            .getMany();
    }

    async create(data: Partial<BranchesEntity>) {
        let branch = new BranchesEntity();
        console.log(data);
        

        branch.addressCity = data.addressCity;
        branch.addressCountryCode = data.addressCountryCode;
        branch.addressPostalCode = data.addressPostalCode;
        branch.addressStreet = data.addressStreet;
        branch.code = data.code;
        branch.addressCountryName = data.addressCountryName;
        branch.departmentId = data.departmentId;

        return this.branchesRepository.save(branch);
    }

    async delete(id: number) {
        let branch = await this.findOne(id);

        if (!branch) {
            throw new Error('Branch not found');
        }
        return this.branchesRepository.delete(id);
    }

    async update(id: number, data: Partial<BranchesEntity>) {
        let branch = await this.findOne(id);

        branch.addressCity = data.addressCity;
        branch.addressCountryCode = data.addressCountryCode;
        branch.addressPostalCode = data.addressPostalCode;
        branch.addressStreet = data.addressStreet;
        branch.code = data.code;
        branch.addressCountryName = data.addressCountryName;
        branch.departmentId = data.departmentId;

        return this.branchesRepository.save({ id, branch });
    }
}
