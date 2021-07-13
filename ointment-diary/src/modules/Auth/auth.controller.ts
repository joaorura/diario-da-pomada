import { Controller, Request, Post, UseGuards, Body } from '@nestjs/common';
import { LocalAuthGuard } from './local-auth.guard';
import { CreateUser } from '../User/user.dto';
import { AuthService } from './auth.service';
import { Public } from 'src/app.metadata';

@Controller('auth')
export class AuthController {
    constructor(private readonly authService: AuthService) {}

    @Public()
    @Post('signin')
    @UseGuards(LocalAuthGuard)
    async signin(@Request() request) {
        return this.authService.signin(request.user);
    }

    @Public()
    @Post('signup')
    async signup(@Body() body: CreateUser) {
        return this.authService.signup(body);
    }
}
