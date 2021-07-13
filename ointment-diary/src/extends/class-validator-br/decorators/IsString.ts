import { IsString as OriginalDecorator, ValidationOptions } from 'class-validator';
import { getValidationOptions } from '../validation';
import { IsStringMessage } from '../messages';

export function IsString(validationOptions?: ValidationOptions): PropertyDecorator {
    return OriginalDecorator(getValidationOptions(IsStringMessage, validationOptions));
}
