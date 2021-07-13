import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { NestjsFormDataModule } from 'nestjs-form-data';
import { HomeCarouselService } from './home-carousel.service';
import { HomeCarouselController } from './home-carousel.controller';
import { HomeCarousel, HomeCarouselSchema } from './home-carousel.entity';
import { ArchiveUploadService } from '../Shared/FileUpload/archive-upload.service';

const HomeCarouselFeature = {
    name: HomeCarousel.name,
    schema: HomeCarouselSchema,
};

@Module({
    controllers: [HomeCarouselController],
    providers: [HomeCarouselService, ArchiveUploadService],
    imports: [NestjsFormDataModule, MongooseModule.forFeature([HomeCarouselFeature])],
})
export class HomeCarouselModule {}
