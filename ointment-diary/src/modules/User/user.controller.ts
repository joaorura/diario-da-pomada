import { Controller, Body, Patch, Delete, Get, Request } from '@nestjs/common';
import { UserService } from './user.service';
import { UpdateUser } from './user.dto';

@Controller('user')
export class UserController {
    constructor(private readonly userService: UserService) {}

    @Get()
    async find(@Request() request) {
        return await this.userService.find(request.user);
    }

    @Patch()
    async update(@Request() request, @Body() body: UpdateUser) {
        return await this.userService.update(request.user, body);
    }

    @Delete()
    async remove(@Request() request) {
        return await this.userService.remove(request.user);
    }
}
