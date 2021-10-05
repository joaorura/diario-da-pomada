import { Controller, Body, Patch, Delete, Get, Request } from '@nestjs/common';
import { RoleEnum } from '../Auth/role-auth.guard';
import { UserService } from './user.service';
import { UpdateUser } from './user.dto';
import { Role } from 'src/app.metadata';

@Controller('user')
export class UserController {
    constructor(private readonly userService: UserService) {}

    @Get()
    async find(@Request() request) {
        return await this.userService.find(request.user);
    }

    @Get('role')
    async findRole(@Request() request) {
        return { role: request.user.role };
    }

    @Get('specific-reports')
    @Role(RoleEnum.Admin)
    async findAllForSpecificReports() {
        return await this.userService.findAllForSpecificReports();
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
