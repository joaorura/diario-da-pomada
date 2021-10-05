import AuthConfig from './auth.config';
import { Module } from '@nestjs/common';
import MongoConfig from './mongo.config';
import { APP_GUARD } from '@nestjs/core';
import { AuthModule } from './modules/Auth/auth.module';
import { NestjsFormDataModule } from 'nestjs-form-data';
import { UserModule } from './modules/User/user.module';
import { RoleGuard } from './modules/Auth/role-auth.guard';
import { JwtAuthGuard } from './modules/Auth/jwt-auth.guard';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { SharedModule } from './modules/Shared/shared.module';
import { ReportsModule } from './modules/Reports/reports.module';
import { CalendaryModule } from './modules/Calendary/calendary.module';
import { QuestionsModule } from './modules/Questions/questions.module';
import { MongooseModule, MongooseModuleOptions } from '@nestjs/mongoose';
import { HomeCarouselModule } from './modules/HomeCarousel/home-carousel.module';
const NodeEnvPath = process.env.NODE_ENV == 'production' ? '.env' : '.env.development';

@Module({
    imports: [
        AuthModule,
        UserModule,
        SharedModule,
        ReportsModule,
        CalendaryModule,
        QuestionsModule,
        HomeCarouselModule,
        NestjsFormDataModule,
        ConfigModule.forRoot({
            load: [AuthConfig, MongoConfig],
            envFilePath: NodeEnvPath,
        }),
        MongooseModule.forRootAsync({
            imports: [ConfigModule],
            inject: [ConfigService],
            useFactory: (configService: ConfigService) => {
                const options: MongooseModuleOptions = {
                    uri: configService.get('mongo.uri'),
                    useUnifiedTopology: configService.get('mongo.options.useUnifiedTopology'),
                    useFindAndModify: configService.get('mongo.options.useFindAndModify'),
                    useNewUrlParser: configService.get('mongo.options.useNewUrlParser'),
                    useCreateIndex: configService.get('mongo.options.useCreateIndex'),
                };
                return options;
            },
        }),
    ],
    providers: [
        { provide: APP_GUARD, useClass: JwtAuthGuard },
        { provide: APP_GUARD, useClass: RoleGuard },
    ],
})
export class AppModule {}
