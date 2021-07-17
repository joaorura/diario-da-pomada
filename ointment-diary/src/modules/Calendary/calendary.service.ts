import { Injectable, InternalServerErrorException, UnprocessableEntityException } from '@nestjs/common';
import { Calendary, CalendaryDocument } from './calendary.entity';
import { CreateCalendary, GetCalendary } from './calendary.dto';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import moment from 'moment';

@Injectable()
export class CalendaryService {
    constructor(@InjectModel(Calendary.name) private calendaryModel: Model<CalendaryDocument>) {}

    create(userId: string, body: CreateCalendary) {
        const calendary = this.createCalendary(body.currentDate);
        return this.calendaryModel.create(Object.assign(calendary, { userId })).catch((e) => {
            throw new UnprocessableEntityException(e.message);
        });
    }

    findByUserId(userId: string, body: GetCalendary) {
        return this.calendaryModel.findOne({ userId }).catch((e) => {
            throw new InternalServerErrorException(e.message);
        });
    }

    private createCalendary(currentDate: Date) {
        const curr = moment(currentDate).add(1, 'day');
        const format = 'YYYY-MM-DD';
        let dueDate: string;
        const weekDays = 7;
        const dates = {};
        const weeks = 6;

        for (let i = 0; i < weeks; i++) {
            for (let i = 0; i <= weekDays; i++, curr.add(1, 'day')) {
                const date = curr.format(format);
                dates[date] = 'daily';

                if (i == 7) {
                    dates[date] = 'weekly';
                    dueDate = date;
                }
            }
        }

        return {
            dates,
            dueDate,
        };
    }
}
