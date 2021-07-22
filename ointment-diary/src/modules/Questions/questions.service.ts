import { DailyQuestion, DailyQuestionDocument, WeeklyQuestion, WeeklyQuestionDocument } from './questions.entity';
import { CreateDailyQuestion, CreateWeeklyQuestion } from './questions.dto';
import { Injectable, UnprocessableEntityException } from '@nestjs/common';
import { CalendaryService } from '../Calendary/calendary.service';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

@Injectable()
export class QuestionsService {
    constructor(
        @InjectModel(WeeklyQuestion.name) private readonly weeklyQuestionModel: Model<WeeklyQuestionDocument>,
        @InjectModel(DailyQuestion.name) private readonly dailyQuestionModel: Model<DailyQuestionDocument>,
        private readonly calendaryService: CalendaryService,
    ) {}

    createWeekly(userId: string, body: CreateWeeklyQuestion) {
        const weeklyQuestion = Object.assign(body, { userId });
        return this.weeklyQuestionModel
            .create(weeklyQuestion)
            .then(async (response) => {
                await this.calendaryService.findAndRemoveWeeklyDateById(userId, body.dataDeMarcacao);
                return response;
            })
            .catch((e) => {
                throw new UnprocessableEntityException(e.message);
            });
    }

    createDaily(userId: string, body: CreateDailyQuestion) {
        const dailyQuestion = Object.assign(body, { userId });
        return this.dailyQuestionModel
            .create(dailyQuestion)
            .then(async (response) => {
                await this.calendaryService.findAndRemoveDailyDateById(userId, body.dataDeMarcacao);
                return response;
            })
            .catch((e) => {
                throw new UnprocessableEntityException(e.message);
            });
    }
}
