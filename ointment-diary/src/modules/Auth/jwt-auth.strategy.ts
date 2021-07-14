import { ExtractJwt, Strategy } from 'passport-jwt';
import { PassportStrategy } from '@nestjs/passport';
import { ConfigService } from '@nestjs/config';
import { Injectable } from '@nestjs/common';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
    constructor(configService: ConfigService) {
        super({
            jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
            algorithms: [configService.get('jwt.signOptions.algorithm')],
            secretOrKey: configService.get('jwt.publicKey'),
            ignoreExpiration: false,
        });
    }

    async validate(payload: any) {
        return { _id: payload.sub, email: payload.username };
    }
}
