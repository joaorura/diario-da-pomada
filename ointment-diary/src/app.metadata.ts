import { RoleEnum } from './modules/Auth/role-auth.guard';
import { SetMetadata } from '@nestjs/common';

export const IS_PUBLIC_KEY = 'isPublic';
export const Public = () => SetMetadata(IS_PUBLIC_KEY, true);

export const ROLE_KEY = 'role';
export const Role = (role: RoleEnum) => SetMetadata(ROLE_KEY, role);
