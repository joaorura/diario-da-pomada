import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { User, UserSchema } from './user.entity';
import { MongooseModule } from '@nestjs/mongoose';
import { UserController } from './user.controller';

const UserFeature = {
    name: User.name,
    schema: UserSchema,
};

@Module({
    exports: [UserService],
    providers: [UserService],
    controllers: [UserController],
    imports: [MongooseModule.forFeature([UserFeature])],
})
export class UserModule {}
