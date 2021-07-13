import { Controller, Body, Patch, Delete } from '@nestjs/common';
import { UserService } from './user.service';
import { DatabaseQuery } from 'src/typpings';
import { UpdateUser } from './user.dto';

@Controller('user')
export class UserController {
    constructor(private readonly userService: UserService) {}

    @Patch()
    async update(@Body() body: UpdateUser) {
        return await this.userService.updateById(body);
    }

    @Delete()
    async remove(@Body() body: DatabaseQuery) {
        return await this.userService.removeById(body.id);
    }
}
