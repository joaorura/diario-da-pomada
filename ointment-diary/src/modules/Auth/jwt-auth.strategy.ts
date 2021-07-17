import { Injectable, UnauthorizedException } from '@nestjs/common';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { PassportStrategy } from '@nestjs/passport';
import { ConfigService } from '@nestjs/config';
import { AuthService } from './auth.service';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
    constructor(private readonly configService: ConfigService, private readonly authService: AuthService) {
        super({
            jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
            algorithms: [configService.get('jwt.signOptions.algorithm')],
            secretOrKey: configService.get('jwt.publicKey'),
            ignoreExpiration: false,
        });
    }

    async validate(payload: any) {
        const user = await this.authService.findUserByUsername(payload.username);
        if (!user) throw new UnauthorizedException();
        return user;
    }
}
