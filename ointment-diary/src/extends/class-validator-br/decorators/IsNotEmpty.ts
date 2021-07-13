import { IsNotEmpty as OriginalDecorator, ValidationOptions } from 'class-validator';
import { getValidationOptions } from '../validation';
import { IsNotEmptyMessage } from '../messages';

export function IsNotEmpty(validationOptions?: ValidationOptions): PropertyDecorator {
    return OriginalDecorator(getValidationOptions(IsNotEmptyMessage, validationOptions));
}
