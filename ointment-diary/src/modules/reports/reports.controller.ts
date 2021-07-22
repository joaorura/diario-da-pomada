import { ReportsService } from './reports.service';
import { RoleEnum } from '../Auth/role-auth.guard';
import { Controller, Get } from '@nestjs/common';
import { Role } from 'src/app.metadata';

@Controller('reports')
export class ReportsController {
    constructor(private readonly reportsService: ReportsService) {}

    @Get('general')
    @Role(RoleEnum.Admin)
    createGeneralReport() {
        return { report: 'General Report' };
    }
}
