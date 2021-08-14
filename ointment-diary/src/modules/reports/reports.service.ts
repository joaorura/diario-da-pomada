import { DailyQuestion, WeeklyQuestion } from '../Questions/questions.entity';
import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { QuestionsService } from '../Questions/questions.service';
import { UserService } from '../User/user.service';
import { User } from '../User/user.entity';
import XlsxPopulate from 'xlsx-populate';
import moment from 'moment-timezone';
import path from 'path';

const srcPath = path.dirname(path.dirname(__dirname));
const reportsPath = path.join(srcPath, 'assets', 'reports');

@Injectable()
export class ReportsService {
    constructor(private readonly questionsService: QuestionsService, private readonly userService: UserService) {}
    async getGeneralReport() {
        try {
            const users = await this.userService.findAllUsersForReports();
            const workbook = await XlsxPopulate.fromFileAsync(`${reportsPath}/general-model.xlsx`);

            const dailyCalendar = [];
            const weeklyCalendar = [];

            for await (const user of users) {
                const weekly = await this.questionsService.findWeekly(user._id);
                const daily = await this.questionsService.findDaily(user._id);
                weeklyCalendar.push({ weekly, user });
                dailyCalendar.push({ daily, user });
            }

            this.createGeneralDailyWorksheet(dailyCalendar, workbook);
            this.createGeneralWeeklyWorksheet(weeklyCalendar, workbook);
            return { file: await workbook.outputAsync('base64') };
        } catch (e) {
            throw new InternalServerErrorException(e.message);
        }
    }

    async getSpecificReport(username: string) {
        try {
            const user = await this.userService.findByUsername(username);
            const workbook = await XlsxPopulate.fromFileAsync(`${reportsPath}/specific-model.xlsx`);
            const weekly = await this.questionsService.findWeekly(user._id);
            const daily = await this.questionsService.findDaily(user._id);
            this.createSpecificPersonalDataWorksheet(user, workbook);
            this.createSpecificWeeklyWorksheet(weekly, workbook);
            this.createSpecificDailyWorksheet(daily, workbook);
            return { file: await workbook.outputAsync('base64') };
        } catch (e) {
            throw new InternalServerErrorException(e.message);
        }
    }

    private createSpecificPersonalDataWorksheet(user: User, workbook) {
        const worksheet = workbook.sheet('Dados Pessoais');

        worksheet.cell('B2').value(user.fullName);
        worksheet.cell('B3').value(moment(user.birthDate).format('DD/MM/YYYY'));
        worksheet.cell('B4').value(user.healthCard);
        worksheet.cell('B5').value(user.nationalCard ?? 'Não Informado');
        worksheet.cell('B6').value(user.email ?? 'Não Informado');
    }

    private createSpecificDailyWorksheet(daily: DailyQuestion[], workbook) {
        const worksheet = workbook.sheet('Diário');

        for (let i = 0, row = 3; i < daily.length; i++, row++) {
            // Data de Preenchimento
            const dataDePreenchimento = daily[i].dataDePreenchimento;
            worksheet.cell('A' + row).value(dataDePreenchimento ? moment(dataDePreenchimento).format('DD/MM/YYYY') : '-');

            // Conseguiu usar a pomada?
            worksheet.cell('B' + row).value(daily[i].usouPomada ? 'Sim' : 'Não');

            // Se não, qual foi o motivo?
            worksheet.cell('C' + row).value(daily[i].motivoNaoUsar ?? '-');
        }
    }

    private createSpecificWeeklyWorksheet(weekly: WeeklyQuestion[], workbook) {
        const worksheet = workbook.sheet('Semanal');

        for (let i = 0, row = 3; i < weekly.length; i++, row++) {
            // Data de Preenchimento
            const dataDePreenchimento = weekly[i].dataDePreenchimento;
            worksheet.cell('A' + row).value(dataDePreenchimento ? moment(dataDePreenchimento).format('DD/MM/YYYY') : '-');

            // Parou o uso da pomada por algum motivo?
            worksheet.cell('B' + row).value(weekly[i].parouUso ? 'Sim' : 'Não');
            // Se sim, qual foi o motivo?
            worksheet.cell('C' + row).value(weekly[i].motivoParadaUso ?? '-');

            // Teve alguma dificuldade na introdução?
            worksheet.cell('D' + row).value(weekly[i].dificuldadeIntroducao ? 'Sim' : 'Não');

            // Seguiu a recomendação de aplicar na hora de dormir e após relações sexuais?
            worksheet.cell('E' + row).value(weekly[i].aplicouDormirSexo ? 'Sim' : 'Não');

            // Sentiu algum incômodo?
            worksheet.cell('F' + row).value(weekly[i].sentiuIncomodo ? 'Sim' : 'Não');
            // Se sim, qual o incômodo?
            worksheet.cell('G' + row).value(weekly[i].tipoIncomodo ?? '-');

            // Como a calcinha fica suja? "Aspecto da saída da pomada"
            worksheet.cell('H' + row).value(weekly[i].tipoSujeiraCalcinha ?? '-');

            // Que cor fica na calcinha?
            worksheet.cell('I' + row).value(weekly[i].tipoCorResiduoCalcinha ?? '-');

            // Percebeu saída de sangue?
            worksheet.cell('J' + row).value(weekly[i].sanguePresente ? 'Sim' : 'Não');

            // Dificultou na relação sexual?
            worksheet.cell('K' + row).value(weekly[i].dificuldadeSexo ? 'Sim' : 'Não');
            // Se sim, qual foi a dificuldade?
            worksheet.cell('L' + row).value(weekly[i].tipoDificuldadeSexo ?? '-');

            // Menstruou por esses dias?
            worksheet.cell('M' + row).value(weekly[i].menstruouRecentemente ? 'Sim' : 'Não');
            // Se sim, qual foi o dia?
            const dataMenstruacao = weekly[i].dataMenstruacao;
            worksheet.cell('N' + row).value(dataMenstruacao ? moment(dataMenstruacao).format('DD/MM/YYYY') : '-');

            // A menstruação foi como antes?
            worksheet.cell('O' + row).value(weekly[i].mestruacaoIgualAnterior ? 'Sim' : 'Não');

            // Se não, qual foi a diferença?
            worksheet.cell('P' + row).value(weekly[i].tipoMestruacaoDiferente ?? '-');
        }
    }

    private createGeneralDailyWorksheet(calendary: { daily: DailyQuestion[]; user: User }[], workbook) {
        const worksheet = workbook.sheet('Diário');

        let row = 3;

        for (const item of calendary) {
            const user = item.user;

            for (const daily of item.daily) {
                // Data de Preenchimento
                const dataDePreenchimento = daily.dataDePreenchimento;
                worksheet.cell('A' + row).value(dataDePreenchimento ? moment(dataDePreenchimento).format('DD/MM/YYYY') : '-');

                // Dados Pessoais
                worksheet.cell('B' + row).value(user.fullName);
                worksheet.cell('C' + row).value(moment(user.birthDate).format('DD/MM/YYYY'));
                worksheet.cell('D' + row).value(user.healthCard);
                worksheet.cell('E' + row).value(user.nationalCard ?? 'Não Informado');
                worksheet.cell('F' + row).value(user.email ?? 'Não Informado');

                // Conseguiu usar a pomada?
                worksheet.cell('G' + row).value(daily.usouPomada ? 'Sim' : 'Não');

                // Se não, qual foi o motivo?
                worksheet.cell('H' + row).value(daily.motivoNaoUsar ?? '-');
                row++;
            }
        }
    }

    private createGeneralWeeklyWorksheet(calendary: { weekly: WeeklyQuestion[]; user: User }[], workbook) {
        const worksheet = workbook.sheet('Semanal');

        let row = 3;

        for (const item of calendary) {
            const user = item.user;

            for (const weekly of item.weekly) {
                // Data de Preenchimento
                const dataDePreenchimento = weekly.dataDePreenchimento;
                worksheet.cell('A' + row).value(dataDePreenchimento ? moment(dataDePreenchimento).format('DD/MM/YYYY') : '-');

                // Dados Pessoais
                worksheet.cell('B' + row).value(user.fullName);
                worksheet.cell('C' + row).value(moment(user.birthDate).format('DD/MM/YYYY'));
                worksheet.cell('D' + row).value(user.healthCard);
                worksheet.cell('E' + row).value(user.nationalCard ?? 'Não Informado');
                worksheet.cell('F' + row).value(user.email ?? 'Não Informado');

                // Parou o uso da pomada por algum motivo?
                worksheet.cell('G' + row).value(weekly.parouUso ? 'Sim' : 'Não');
                // Se sim, qual foi o motivo?
                worksheet.cell('H' + row).value(weekly.motivoParadaUso ?? '-');

                // Teve alguma dificuldade na introdução?
                worksheet.cell('I' + row).value(weekly.dificuldadeIntroducao ? 'Sim' : 'Não');

                // Seguiu a recomendação de aplicar na hora de dormir e após relações sexuais?
                worksheet.cell('J' + row).value(weekly.aplicouDormirSexo ? 'Sim' : 'Não');

                // Sentiu algum incômodo?
                worksheet.cell('K' + row).value(weekly.sentiuIncomodo ? 'Sim' : 'Não');
                // Se sim, qual o incômodo?
                worksheet.cell('L' + row).value(weekly.tipoIncomodo ?? '-');

                // Como a calcinha fica suja? "Aspecto da saída da pomada"
                worksheet.cell('M' + row).value(weekly.tipoSujeiraCalcinha ?? '-');

                // Que cor fica na calcinha?
                worksheet.cell('N' + row).value(weekly.tipoCorResiduoCalcinha ?? '-');

                // Percebeu saída de sangue?
                worksheet.cell('O' + row).value(weekly.sanguePresente ? 'Sim' : 'Não');

                // Dificultou na relação sexual?
                worksheet.cell('P' + row).value(weekly.dificuldadeSexo ? 'Sim' : 'Não');
                // Se sim, qual foi a dificuldade?
                worksheet.cell('Q' + row).value(weekly.tipoDificuldadeSexo ?? '-');

                // Menstruou por esses dias?
                worksheet.cell('R' + row).value(weekly.menstruouRecentemente ? 'Sim' : 'Não');
                // Se sim, qual foi o dia?
                const dataMenstruacao = weekly.dataMenstruacao;
                worksheet.cell('S' + row).value(dataMenstruacao ? moment(dataMenstruacao).format('DD/MM/YYYY') : '-');

                // A menstruação foi como antes?
                worksheet.cell('T' + row).value(weekly.mestruacaoIgualAnterior ? 'Sim' : 'Não');

                // Se não, qual foi a diferença?
                worksheet.cell('U' + row).value(weekly.tipoMestruacaoDiferente ?? '-');

                row++;
            }
        }
    }
}
