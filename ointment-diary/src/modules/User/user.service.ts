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

    find(user: User) {
        return this.findByUsername(user.email);
    }

    findAllForReports() {
        return this.userModel.find({ role: 'user' }).catch((e) => {
            throw new InternalServerErrorException(e.message);
        });
    }

    async findAllForSpecificReports() {
        return {
            users: await this.userModel
                .find({ role: 'user' })
                .select(['fullName', 'healthCard'])
                .catch((e) => {
                    throw new InternalServerErrorException(e.message);
                }),
        };
    }

    async update(user: User, body: UpdateUser) {
        if (Object.values(body).length) {
            await this.userModel.findByIdAndUpdate(user._id, body, { new: true }).catch((e) => {
                throw new UnprocessableEntityException(e.message);
            });
        } else {
            throw new UnprocessableEntityException('O objeto de atualização não pode ser vazio.');
        }
    }

    remove(user: User) {
        return this.userModel.findByIdAndDelete(user._id).catch((e) => {
            throw new InternalServerErrorException(e.message);
        });
    }

    findById(id: string, select = ['-password']) {
        return this.userModel
            .findById(id)
            .select(select)
            .catch((e) => {
                throw new InternalServerErrorException(e.message);
            });
    }

    findByUsername(username: string, select: string[] = []) {
        const or = [{ email: username }, { healthCard: username }, { nationalCard: username }];
        return this.userModel
            .findOne({ $or: or })
            .select(select)
            .catch((e) => {
                throw new InternalServerErrorException(e.message);
            });
    }

    async validate(username: string, password: string): Promise<User | null> {
        const user = (await this.findByUsername(username, ['+password'])) as any;
        const isValid = await user?.comparePassword(password);
        return isValid ? user : null;
    }
}
