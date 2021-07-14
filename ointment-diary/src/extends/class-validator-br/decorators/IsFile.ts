import { IsFile as OriginalDecorator } from 'nestjs-form-data';
import { getValidationOptions } from '../validation';
import { ValidationOptions } from 'class-validator';
import { IsFileMessage } from '../messages';

export function IsFile(validationOptions?: ValidationOptions): PropertyDecorator {
    return OriginalDecorator(getValidationOptions(IsFileMessage, validationOptions));
}
