import { MaxLength as OriginalDecorator, ValidationOptions } from 'class-validator';
import { getValidationOptions } from '../validation';
import { MaxLengthMessage } from '../messages';

export function MaxLength(maxLength: number, validationOptions?: ValidationOptions): PropertyDecorator {
    return OriginalDecorator(maxLength, getValidationOptions(MaxLengthMessage, validationOptions));
}
