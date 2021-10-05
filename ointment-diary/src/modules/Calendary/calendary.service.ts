import { Injectable, InternalServerErrorException, NotFoundException, UnprocessableEntityException } from '@nestjs/common';
import { Calendary, CalendaryDocument } from './calendary.entity';
import { CreateCalendary, GetCalendary } from './calendary.dto';
import { InjectModel } from '@nestjs/mongoose';
import moment from 'moment-timezone';
import { Model } from 'mongoose';

@Injectable()
export class CalendaryService {
    constructor(@InjectModel(Calendary.name) private calendaryModel: Model<CalendaryDocument>) {}

    create(userId: string, body: CreateCalendary) {
        const calendary = this.createCalendary(body.currentDate);
        const completeCalendary = Object.assign(calendary, { userId });
        return this.calendaryModel.create(completeCalendary).catch((e) => {
            throw new UnprocessableEntityException(e.message);
        });
    }

    update(userId: string, body: GetCalendary) {
        const calendary = this.createCalendary(body.currentDate) as any;
        return this.calendaryModel.findOneAndUpdate({ userId }, calendary).catch((e) => {
            throw new UnprocessableEntityException(e.message);
        });
    }

    async findByUserId(userId: string, body: GetCalendary) {
        const finded = await this.calendaryModel.findOne({ userId }).catch((e) => {
            throw new InternalServerErrorException(e.message);
        });

        if (finded) {
            const expired = moment(body.currentDate).isAfter(finded.dueDate);

            if (expired) {
                const { weekly, daily } = await this.update(userId, body);
                return { weekly, daily, isNew: true };
            }

            const { weekly, daily } = finded;
            return { weekly, daily, isNew: false };
        }

        return null;
    }

    async findAndRemoveWeeklyDateById(userId, date: Date) {
        const finded = await this.calendaryModel.findOne({ userId }).catch((e) => {
            throw new InternalServerErrorException(e.message);
        });

        if (finded) {
            finded.weekly.forEach((weeklyDate, index) => {
                if (moment(date).isSame(weeklyDate)) {
                    finded.weekly.splice(index, 1);
                }
            });

            finded.save();
        } else {
            const message = 'Esse usuário não tem um calendário semanal.';
            throw new NotFoundException({ message: 'Not Found', statusCode: 404 }, message);
        }
    }

    async findAndRemoveDailyDateById(userId, date: Date) {
        const finded = await this.calendaryModel.findOne({ userId }).catch((e) => {
            throw new InternalServerErrorException(e.message);
        });

        if (finded) {
            finded.daily.forEach((dailyDate, index) => {
                if (moment(date).isSame(dailyDate)) {
                    finded.daily.splice(index, 1);
                }
            });

            finded.save();
        } else {
            const message = 'Esse usuário não tem um calendário diário.';
            throw new NotFoundException({ message: 'Not Found', statusCode: 404 }, message);
        }
    }

    private createCalendary(currentDate: Date) {
        const curr = moment(currentDate);
        const format = 'YYYY-MM-DD';
        let dueDate: string;
        const weekDays = 7;
        const weekly = [];
        const daily = [];
        const weeks = 12;

        for (let i = 0; i < weeks; i++) {
            for (let i = 0; i <= weekDays; i++, curr.add(1, 'day')) {
                const date = curr.format(format);
                daily.push(date);

                if (i == 7) {
                    weekly.push(date);
                    dueDate = date;
                }
            }
        }

        return {
            daily,
            weekly,
            dueDate,
        };
    }
}
