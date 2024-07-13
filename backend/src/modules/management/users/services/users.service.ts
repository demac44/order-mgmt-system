import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { read } from 'fs';
import { UsersEntity } from 'src/db';
import { Repository } from 'typeorm';

@Injectable()
export class UsersService {


    constructor(
        @InjectRepository(UsersEntity) private readonly usersRepository: Repository<UsersEntity>
    ) {}


    async getUsers() {
        return await this.usersRepository.createQueryBuilder('users')
            .getMany();
    }

    async create(data: any) {
        let newUser = new UsersEntity();

        newUser.firstName = data.firstName;
        newUser.lastName = data.lastName;
        newUser.email = data.email;
        newUser.password = data.password;
        newUser.role = data.role;
        


        return await this.usersRepository.save(data);
    }

}
