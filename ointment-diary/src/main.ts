import { Logger, ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import express from 'express';

async function bootstrap() {
    const app = await NestFactory.create(AppModule);

    const port = process.env.PORT || 3000;
    const environment = process.env.NODE_ENV;

    app.use(express.urlencoded({ extended: true }));
    app.useGlobalPipes(new ValidationPipe());
    app.use(express.json());

    await app.listen(port, () => {
        Logger.log(`Listening at ${port}.`);
        Logger.log(`Running in ${environment} mode.`);
    });
}
bootstrap();
