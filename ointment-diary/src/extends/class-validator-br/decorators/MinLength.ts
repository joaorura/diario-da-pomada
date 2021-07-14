import { MinLength as OriginalDecorator, ValidationOptions } from 'class-validator';
import { getValidationOptions } from '../validation';
import { MinLengthMessage } from '../messages';

export function MinLength(minLength: number, validationOptions?: ValidationOptions): PropertyDecorator {
    return OriginalDecorator(minLength, getValidationOptions(MinLengthMessage, validationOptions));
}
