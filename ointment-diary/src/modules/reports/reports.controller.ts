import { Body, Controller, Get, Post } from '@nestjs/common';
import { ReportsService } from './reports.service';
import { RoleEnum } from '../Auth/role-auth.guard';
import { GetSpecificReport } from './reports.dto';
import { Role } from 'src/app.metadata';

@Controller('reports')
export class ReportsController {
    constructor(private readonly reportsService: ReportsService) {}

    @Get('general')
    @Role(RoleEnum.Admin)
    async createGeneralReport() {
        return await this.reportsService.getGeneralReport();
    }

    @Post('specific')
    @Role(RoleEnum.Admin)
    async createSpecificReport(@Body() body: GetSpecificReport) {
        return await this.reportsService.getSpecificReport(body.healthCard);
    }
}
