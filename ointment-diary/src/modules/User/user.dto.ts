import {
    IsString,
    MinLength,
    MaxLength,
    IsNotEmpty,
    IsDateOnly,
    IsEmailNull,
    FixedLength,
    IsStringNull,
    FixedLengthNull,
} from 'src/extends/class-validator-br';
import { PartialType } from '@nestjs/mapped-types';

export class CreateUser {
    @IsEmailNull()
    email?: string;

    @IsNotEmpty()
    @IsDateOnly()
    birthDate: Date;

    @IsString()
    @IsNotEmpty()
    @MinLength(2)
    @MaxLength(128)
    fullName: string;

    @IsString()
    @IsNotEmpty()
    @MinLength(4)
    @MaxLength(128)
    password: string;

    @IsString()
    @IsNotEmpty()
    @FixedLength(15)
    healthCard: string;

    @IsStringNull()
    @FixedLengthNull(11)
    nationalCard?: string;
}

export class UpdateUser extends PartialType(CreateUser) {}
