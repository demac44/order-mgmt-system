import { Body, Controller, Get, Post, Session, UseGuards } from '@nestjs/common';
import { AuthService } from '../services/auth.service';
import { UserAuthenticated } from 'src/guards/user-authenticated.guard';
import { UserId } from 'src/common/decorators/param/user';

@Controller('mgmt/auth')
export class AuthController {

    constructor(
        private readonly authService: AuthService
    ){}

    @Post('/login')
    login(@Body() login: { username: string; password: string }, @Session() session) {
        return this.authService.login(login.username, login.password, session.id)
    }

    @Post('/logout')
    @UseGuards(UserAuthenticated)
    logout(@Session() session, @UserId() userId) {
        return this.authService.logout(userId, session.id)
    }

    @Get('/')
    @UseGuards(UserAuthenticated)
    admin(@UserId() userId) {
        return this.authService.user(userId)
    }

    @Post('/password-change')
    @UseGuards(UserAuthenticated)
    changePassword(@Body() passwordChange: {
        oldPassword: string;
        newPassword: string;
    }, @UserId() adminId) {
        return this.authService.passwordChange(adminId, passwordChange.oldPassword, passwordChange.newPassword)
    }

    @Post('/create')
    @UseGuards(UserAuthenticated)
    create(@Body() create: {
        email: string;
        firstName: string;
        lastName: string;
        password: string;
    
    }) {
        return this.authService.create(create.email, create.firstName, create.lastName, create.password)
    }

}
