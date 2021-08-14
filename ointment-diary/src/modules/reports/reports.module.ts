import { Module } from '@nestjs/common';
import { UserModule } from '../User/user.module';
import { ReportsService } from './reports.service';
import { ReportsController } from './reports.controller';
import { QuestionsModule } from '../Questions/questions.module';

@Module({
    imports: [QuestionsModule, UserModule],
    controllers: [ReportsController],
    providers: [ReportsService],
})
export class ReportsModule {}
