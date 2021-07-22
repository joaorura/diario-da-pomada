import { CreateHomeCarousel, UpdateHomeCarousel } from './home-carousel.dto';
import { Get, Post, Body, Patch, Delete, Controller } from '@nestjs/common';
import { HomeCarouselService } from './home-carousel.service';
import { FormDataRequest } from 'nestjs-form-data';
import { RoleEnum } from '../Auth/role-auth.guard';
import { DatabaseQuery } from 'src/typpings';
import { Public } from 'src/app.metadata';
import { Role } from 'src/app.metadata';

@Controller('home-carousel')
export class HomeCarouselController {
    constructor(private readonly homeCarouselService: HomeCarouselService) {}
    @Post()
    @FormDataRequest()
    @Role(RoleEnum.Admin)
    async create(@Body() body: CreateHomeCarousel) {
        return await this.homeCarouselService.create(body);
    }

    @Get()
    @Public()
    @Role(RoleEnum.Public)
    async findAll() {
        return await this.homeCarouselService.findAll();
    }

    @Patch()
    @Role(RoleEnum.Admin)
    async updateById(@Body() body: UpdateHomeCarousel) {
        return await this.homeCarouselService.updateById(body);
    }

    @Delete()
    @Role(RoleEnum.Admin)
    async removeById(@Body() body: DatabaseQuery) {
        return await this.homeCarouselService.removeById(body.id);
    }
}
