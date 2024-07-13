import { HttpException, Injectable, UnprocessableEntityException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { UsersEntity, UsersSessionsEntity } from 'src/db';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
    private saltOrRounds = 10;

    constructor (
        @InjectRepository(UsersEntity) private readonly usersRepo: Repository<UsersEntity>,
        @InjectRepository(UsersSessionsEntity) private readonly usersSessionsRepo: Repository<UsersSessionsEntity>,
    ) {}

    async create(email: string, firstName: string, lastName: string, password: string) {
        let admin = new UsersEntity()

        admin.email = email
        admin.password = await bcrypt.hash(password, this.saltOrRounds)
        admin.firstName = firstName
        admin.lastName = lastName

        admin = await this.usersRepo.save(admin)

        return { success: true, data: admin }
    }

    async login(username: string, password: string, sessionId) {        

        let user = await this.usersRepo.createQueryBuilder('user')
        .leftJoinAndMapOne('user.role', 'user.role', 'role')    
        .where({ username })
        .getOne();

        if (!user) throw new HttpException('User not found', 404)

        let passwordMatching = await bcrypt.compare(password, user.password)

        if (!passwordMatching) throw new HttpException('Incorrect password', 401)

        await this.usersSessionsRepo.update({ id: sessionId }, { userId: user.id })

        return user
    }

    async logout(userId: number, sessionId: string) {
        await this.usersSessionsRepo.update({ id: sessionId, userId }, { userId: null })
        return { success: true, message: '' }
    }

    async user(userId: number) {
        return this.usersRepo.findOneOrFail({
            where: { id: userId }
        })
    }

    async passwordChange(id: number, oldPassword: string, newPassword: string) {
        let user = await this.usersRepo.findOneOrFail({
            where: { id }
        })

        let passwordMatching = await bcrypt.compare(oldPassword, user.password)

        if (!passwordMatching) throw new HttpException('Incorrect password', 401)

        user.password = await bcrypt.hash(newPassword, this.saltOrRounds)

        user = await this.usersRepo.save(user)

        return { success: true }
    }
}
