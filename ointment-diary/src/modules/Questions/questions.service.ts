import { DailyQuestion, DailyQuestionDocument, WeeklyQuestion, WeeklyQuestionDocument } from './questions.entity';
import { CreateDailyQuestion, CreateWeeklyQuestion } from './questions.dto';
import { Injectable, UnprocessableEntityException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

@Injectable()
export class QuestionsService {
    constructor(
        @InjectModel(WeeklyQuestion.name) private weeklyQuestionModel: Model<WeeklyQuestionDocument>,
        @InjectModel(DailyQuestion.name) private dailyQuestionModel: Model<DailyQuestionDocument>,
    ) {}

    createWeekly(userId: string, body: CreateWeeklyQuestion) {
        const weeklyQuestion = Object.assign(body, { userId });
        return this.weeklyQuestionModel.create(weeklyQuestion).catch((e) => {
            throw new UnprocessableEntityException(e.message);
        });
    }

    createDaily(userId: string, body: CreateDailyQuestion) {
        const dailyQuestion = Object.assign(body, { userId });
        return this.dailyQuestionModel.create(dailyQuestion).catch((e) => {
            throw new UnprocessableEntityException(e.message);
        });
    }
}
