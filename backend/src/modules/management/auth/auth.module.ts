import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersEntity, UsersRolesEntity, UsersSessionsEntity } from 'src/db';
import { UsersPermissionsEntity } from 'src/db/entities/users/UsersPermissionsEntity';
import { UsersRolesPermissionsEntity } from 'src/db/entities/users/UsersRolesPermissionsEntity';
import { AuthController } from './controllers/auth.controller';
import { AuthService } from './services/auth.service';

@Module({
    controllers: [AuthController],
    providers: [AuthService],
    imports: [
        TypeOrmModule.forFeature([
            UsersEntity,
            UsersSessionsEntity,
            UsersRolesEntity,
            UsersPermissionsEntity,
            UsersRolesEntity,
            UsersRolesPermissionsEntity
        ])
    ]
})
export class AuthModule {}
