import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { ROLE_KEY } from 'src/app.metadata';
import { Reflector } from '@nestjs/core';

export enum RoleEnum {
    Public = 'public',
    Admin = 'admin',
    User = 'user',
}

@Injectable()
export class RoleGuard implements CanActivate {
    constructor(private reflector: Reflector) {}

    canActivate(context: ExecutionContext): boolean {
        const requiredRole = this.reflector.getAllAndOverride<RoleEnum>(ROLE_KEY, [context.getHandler(), context.getClass()]);
        const { user } = context.switchToHttp().getRequest();

        if (requiredRole == RoleEnum.Public) {
            return true;
        }

        if (user) {
            if (!requiredRole) {
                const isUser = user.role == RoleEnum.User;
                const isAdmin = user.role == RoleEnum.Admin;
                return isUser || isAdmin;
            }

            return requiredRole == user.role;
        }

        return false;
    }
}
