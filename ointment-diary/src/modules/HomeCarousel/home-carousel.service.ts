import { Injectable, InternalServerErrorException, NotFoundException, UnprocessableEntityException } from '@nestjs/common';
import { ArchiveUploadService } from '../Shared/FileUpload/archive-upload.service';
import { CreateHomeCarousel, UpdateHomeCarousel } from './home-carousel.dto';
import { HomeCarousel, HomeCarouselDocument } from './home-carousel.entity';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

@Injectable()
export class HomeCarouselService {
    constructor(
        @InjectModel(HomeCarousel.name) private homeCarouselModel: Model<HomeCarouselDocument>,
        private archiveUpload: ArchiveUploadService,
    ) {}

    async create(body: CreateHomeCarousel) {
        const readedFile = await this.archiveUpload.up(body.image).catch((e) => {
            throw new UnprocessableEntityException(e.message);
        });

        const object = Object.assign(body, readedFile);
        return await this.homeCarouselModel.create(object).catch((e) => {
            throw new UnprocessableEntityException(e.message);
        });
    }

    async update(body: UpdateHomeCarousel) {
        const readedFile = await this.archiveUpload.up(body.image).catch((e) => {
            throw new UnprocessableEntityException(e.message);
        });

        const object = Object.assign(body, readedFile);
        return await this.homeCarouselModel.findByIdAndUpdate(body.id, object, { new: true }).catch((e) => {
            throw new UnprocessableEntityException(e.message);
        });
    }

    findAll() {
        return this.homeCarouselModel.find().catch((e) => {
            throw new InternalServerErrorException(e.message);
        });
    }

    async removeOne(id: string) {
        const finded = await this.homeCarouselModel.findById(id).catch((e) => {
            throw new InternalServerErrorException(e.message);
        });

        if (finded) return await finded.delete();
        else throw new NotFoundException('Registro não encontrado.');
    }
}
