import { Controller, Request, Post, UseGuards, Body } from '@nestjs/common';
import { LocalAuthGuard } from './local-auth.guard';
import { RoleEnum } from '../Auth/role-auth.guard';
import { CreateUser } from '../User/user.dto';
import { AuthService } from './auth.service';
import { Public } from 'src/app.metadata';
import { Role } from 'src/app.metadata';

@Controller('auth')
export class AuthController {
    constructor(private readonly authService: AuthService) {}

    @Public()
    @Post('signin')
    @Role(RoleEnum.Public)
    @UseGuards(LocalAuthGuard)
    async signin(@Request() request) {
        return await this.authService.signin(request.user);
    }

    @Public()
    @Post('signup')
    @Role(RoleEnum.Public)
    async signup(@Body() body: CreateUser) {
        return await this.authService.signup(body);
    }
}
