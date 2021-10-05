import { IsBoolean as OriginalDecorator, ValidationOptions } from 'class-validator';
import { getValidationOptions } from '../validation';
import { IsBooleanMessage } from '../messages';

export function IsBoolean(validationOptions?: ValidationOptions): PropertyDecorator {
    return OriginalDecorator(getValidationOptions(IsBooleanMessage, validationOptions));
}
