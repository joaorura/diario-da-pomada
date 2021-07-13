import { ConfigModule, ConfigService } from '@nestjs/config';
import { JwtModule, JwtModuleOptions } from '@nestjs/jwt';
import { LocalStrategy } from './local-auth.strategy';
import { AuthController } from './auth.controller';
import { PassportModule } from '@nestjs/passport';
import { JwtStrategy } from './jwt-auth.strategy';
import { UserModule } from '../User/user.module';
import { AuthService } from './auth.service';
import { Module } from '@nestjs/common';

@Module({
    controllers: [AuthController],
    imports: [
        UserModule,
        ConfigModule,
        PassportModule,
        JwtModule.registerAsync({
            imports: [ConfigModule],
            inject: [ConfigService],
            useFactory: (configService: ConfigService) => {
                const jwtOptions: JwtModuleOptions = {
                    privateKey: configService.get('jwt.privateKey'),
                    publicKey: configService.get('jwt.publicKey'),
                    signOptions: {
                        algorithm: configService.get('jwt.signOptions.algorithm'),
                        expiresIn: configService.get('jwt.signOptions.expiresIn'),
                    },
                };
                return jwtOptions;
            },
        }),
    ],
    providers: [AuthService, LocalStrategy, JwtStrategy],
})
export class AuthModule {}
