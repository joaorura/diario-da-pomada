import AuthConfig from './auth.config';
import { Module } from '@nestjs/common';
import { APP_GUARD } from '@nestjs/core';
import { ConfigModule } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './modules/Auth/auth.module';
import { NestjsFormDataModule } from 'nestjs-form-data';
import { UserModule } from './modules/User/user.module';
import { MONGODB_URI, mongoOptions } from './app.config';
import { JwtAuthGuard } from './modules/Auth/jwt-auth.guard';
import { SharedModule } from './modules/Shared/shared.module';
import { CalendaryModule } from './modules/Calendary/calendary.module';
import { HomeCarouselModule } from './modules/HomeCarousel/home-carousel.module';

@Module({
    imports: [
        AuthModule,
        SharedModule,
        UserModule,
        HomeCarouselModule,
        NestjsFormDataModule,
        ConfigModule.forRoot({ load: [AuthConfig] }),
        MongooseModule.forRoot(MONGODB_URI, mongoOptions),
        CalendaryModule,
    ],
    providers: [{ provide: APP_GUARD, useClass: JwtAuthGuard }],
})
export class AppModule {}
