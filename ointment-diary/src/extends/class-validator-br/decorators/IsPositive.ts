import { IsPositive as OriginalDecorator, ValidationOptions } from 'class-validator';
import { getValidationOptions } from '../validation';
import { IsPositiveMessage } from '../messages';

export function IsPositive(validationOptions?: ValidationOptions): PropertyDecorator {
    return OriginalDecorator(getValidationOptions(IsPositiveMessage, validationOptions));
}
