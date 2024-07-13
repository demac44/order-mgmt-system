import { HttpException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TablesEntity } from 'src/db';
import { Repository } from 'typeorm';

@Injectable()
export class TablesService {

    constructor(
        @InjectRepository(TablesEntity) private readonly tablesRepository: Repository<TablesEntity>
    ) {}

    async getOne(id: number) {
        let table = await this.tablesRepository.createQueryBuilder('tables')
        .leftJoinAndMapMany('tables.orders', 'tables.orders', 'orders')
        .where({ id })
        .getOne();

        if (!table) {
            throw new HttpException('Table not found', 404);
        }

        return table
    }

    async getAll(branchId: number, filters?: { joinOrders?: boolean; withOrders?: boolean}) {
        let query = this.tablesRepository.createQueryBuilder('tables')

        if(filters?.joinOrders) {
            if(filters?.withOrders) {
                query.innerJoinAndMapMany('tables.orders', 'tables.orders', 'orders')
            } else {
                query.leftJoinAndMapMany('tables.orders', 'tables.orders', 'orders')
            }
        }

        return query.getMany();
    }

    async create(data: { code: string, branchId: number }) {
        let table = new TablesEntity();

        table.code = data.code;
        table.branchId = data.branchId;

        return this.tablesRepository.save(table);
    }

    async update(id: number, data: { code?: string }) {
        let table = await this.getOne(id);

        return this.tablesRepository.save({ id: table.id, code: data.code });
    
    }

    async delete(id: number) {            
        let table = await this.getOne(id);

        await this.tablesRepository.softDelete(id);

        return table;
    }


}
