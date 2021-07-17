import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { CalendaryService } from './calendary.service';
import { CalendaryController } from './calendary.controller';
import { Calendary, CalendarySchema } from './calendary.entity';

const CalendaryFeature = {
    name: Calendary.name,
    schema: CalendarySchema,
};

@Module({
    exports: [CalendaryService],
    providers: [CalendaryService],
    controllers: [CalendaryController],
    imports: [MongooseModule.forFeature([CalendaryFeature])],
})
export class CalendaryModule {}
