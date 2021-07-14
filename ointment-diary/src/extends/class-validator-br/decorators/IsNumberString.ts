import { IsNumberString as OriginalDecorator, ValidationOptions } from 'class-validator';
import { getValidationOptions } from '../validation';
import { IsNumberStringMessage } from '../messages';

export function IsNumberString(validationOptions?: ValidationOptions): PropertyDecorator {
    return OriginalDecorator({}, getValidationOptions(IsNumberStringMessage, validationOptions));
}
