import { DailyQuestion, DailyQuestionSchema, WeeklyQuestion, WeeklyQuestionSchema } from './questions.entity';
import { CalendaryModule } from '../Calendary/calendary.module';
import { QuestionsController } from './questions.controller';
import { QuestionsService } from './questions.service';
import { MongooseModule } from '@nestjs/mongoose';
import { Module } from '@nestjs/common';

const WeeklyQuestionFeature = {
    name: WeeklyQuestion.name,
    schema: WeeklyQuestionSchema,
};

const DailyQuestionFeature = {
    name: DailyQuestion.name,
    schema: DailyQuestionSchema,
};

@Module({
    exports: [QuestionsService],
    providers: [QuestionsService],
    controllers: [QuestionsController],
    imports: [CalendaryModule, MongooseModule.forFeature([WeeklyQuestionFeature, DailyQuestionFeature])],
})
export class QuestionsModule {}
