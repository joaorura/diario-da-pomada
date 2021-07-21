import { CreateDailyQuestion, CreateWeeklyQuestion } from './questions.dto';
import { Body, Controller, Post, Request } from '@nestjs/common';
import { QuestionsService } from './questions.service';

@Controller('questions')
export class QuestionsController {
    constructor(private readonly questionsService: QuestionsService) {}

    @Post('weekly')
    async createWeekly(@Request() request, @Body() body: CreateWeeklyQuestion) {
        return await this.questionsService.createWeekly(request.user._id, body);
    }

    @Post('daily')
    async createDaily(@Request() request, @Body() body: CreateDailyQuestion) {
        return await this.questionsService.createDaily(request.user._id, body);
    }
}
