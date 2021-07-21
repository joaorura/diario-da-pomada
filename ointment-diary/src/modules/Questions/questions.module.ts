import { DailyQuestion, DailyQuestionSchema, WeeklyQuestion, WeeklyQuestionSchema } from './questions.entity';
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
    providers: [QuestionsService],
    controllers: [QuestionsController],
    imports: [MongooseModule.forFeature([WeeklyQuestionFeature, DailyQuestionFeature])],
})
export class QuestionsModule {}
