import { Injectable, InternalServerErrorException, UnprocessableEntityException } from '@nestjs/common';
import { CreateUser, UpdateUser } from './user.dto';
import { User, UserDocument } from './user.entity';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

@Injectable()
export class UserService {
    constructor(@InjectModel(User.name) private userModel: Model<UserDocument>) {}

    async create(body: CreateUser) {
        return await this.userModel.create(body).catch((e) => {
            throw new UnprocessableEntityException(e.message);
        });
    }

    async updateById(body: UpdateUser) {
        return await this.userModel.findByIdAndUpdate(body.id, body, { new: true }).catch((e) => {
            throw new UnprocessableEntityException(e.message);
        });
    }

    async removeById(id: string) {
        return await this.userModel.findByIdAndDelete(id).catch((e) => {
            throw new InternalServerErrorException(e.message);
        });
    }

    async findOneByUsername(username: string) {
        const or = [{ email: username }, { healthCard: username }, { nationalCard: username }];
        return await this.userModel.findOne({ $or: or }).catch((e) => {
            throw new InternalServerErrorException(e.message);
        });
    }

    async validate(username: string, password: string): Promise<User | null> {
        const user: any = await this.findOneByUsername(username);
        return (await user?.comparePassword(password)) ? user : null;
    }
}
