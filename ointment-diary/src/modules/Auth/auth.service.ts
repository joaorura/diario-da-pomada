import { UserService } from '../User/user.service';
import { CreateUser } from '../User/user.dto';
import { Injectable } from '@nestjs/common';
import { AuthPayload } from './auth.entity';
import { User } from '../User/user.entity';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
    constructor(private userService: UserService, private jwtService: JwtService) {}

    async validate(username: string, password: string) {
        return this.userService.validate(username, password);
    }

    createNewAccessToken(payload: AuthPayload) {
        return { access_token: this.jwtService.sign(payload) };
    }

    async signin(user: User) {
        return this.createNewAccessToken({ username: user.email, sub: user._id });
    }

    async signup(body: CreateUser) {
        const user = await this.userService.create(body);
        return this.createNewAccessToken({ username: user.email, sub: user._id });
    }
}
