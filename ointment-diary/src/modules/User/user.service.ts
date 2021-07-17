import { Injectable, InternalServerErrorException, UnprocessableEntityException } from '@nestjs/common';
import { CalendaryService } from '../Calendary/calendary.service';
import { CreateUser, UpdateUser } from './user.dto';
import { User, UserDocument } from './user.entity';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

@Injectable()
export class UserService {
    constructor(
        @InjectModel(User.name) private readonly userModel: Model<UserDocument>,
        private readonly calendaryService: CalendaryService,
    ) {}

    create(body: CreateUser) {
        return this.userModel
            .create(body)
            .then(async (response) => {
                await this.calendaryService.create(response.id, { currentDate: response.createdAt });
                return response;
            })
            .catch((e) => {
                throw new UnprocessableEntityException(e.message);
            });
    }

    updateById(body: UpdateUser) {
        return this.userModel.findByIdAndUpdate(body.id, body, { new: true }).catch((e) => {
            throw new UnprocessableEntityException(e.message);
        });
    }

    removeById(id: string) {
        return this.userModel.findByIdAndDelete(id).catch((e) => {
            throw new InternalServerErrorException(e.message);
        });
    }

    findByUsername(username: string) {
        const or = [{ email: username }, { healthCard: username }, { nationalCard: username }];
        return this.userModel.findOne({ $or: or }).catch((e) => {
            throw new InternalServerErrorException(e.message);
        });
    }

    async validate(username: string, password: string): Promise<User | null> {
        const user = (await this.findByUsername(username)) as any;
        const isValid = await user?.comparePassword(password);
        return isValid ? user : null;
    }
}
