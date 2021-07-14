import {
    IsFile,
    IsString,
    MaxLength,
    IsNotEmpty,
    HasMimeType,
    MaxFileSize,
    IsNumberString,
} from 'src/extends/class-validator-br';
const MimeTypeAllowList = ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'];
import { IsMongoId } from 'src/extends/class-validator-br';
import { MemoryStoredFile } from 'nestjs-form-data';
import { PartialType } from '@nestjs/mapped-types';

export class CreateHomeCarousel {
    @IsString()
    @IsNotEmpty()
    @MaxLength(128)
    header: string;

    @IsString()
    @IsNotEmpty()
    @MaxLength(128)
    description: string;

    @IsNotEmpty()
    @IsNumberString()
    imagePosition: number;

    @IsFile()
    @MaxFileSize(1e7)
    @HasMimeType(MimeTypeAllowList)
    image: MemoryStoredFile;
}

export class UpdateHomeCarousel extends PartialType(CreateHomeCarousel) {
    @IsNotEmpty()
    @IsMongoId()
    id: string;
}
