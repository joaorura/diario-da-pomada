import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { User, UserSchema } from './user.entity';
import { MongooseModule } from '@nestjs/mongoose';
import { UserController } from './user.controller';
import { CalendaryModule } from '../Calendary/calendary.module';

const UserFeature = {
    name: User.name,
    schema: UserSchema,
};

@Module({
    exports: [UserService],
    providers: [UserService],
    controllers: [UserController],
    imports: [MongooseModule.forFeature([UserFeature]), CalendaryModule],
})
export class UserModule {}
