import {
    IsEmail,
    IsString,
    IsMongoId,
    MinLength,
    MaxLength,
    IsNotEmpty,
    IsDateOnly,
    FixedLength,
} from 'src/extends/class-validator-br';
import { PartialType } from '@nestjs/mapped-types';

export class CreateUser {
    @IsEmail()
    @IsNotEmpty()
    email: string;

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
    @MinLength(8)
    @MaxLength(128)
    password: string;

    @IsString()
    @IsNotEmpty()
    @FixedLength(15)
    healthCard: string;

    @IsString()
    @IsNotEmpty()
    @FixedLength(11)
    nationalCard: string;
}

export class UpdateUser extends PartialType(CreateUser) {
    @IsNotEmpty()
    @IsMongoId()
    id: string;
}
