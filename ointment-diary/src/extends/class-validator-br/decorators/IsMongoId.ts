import { IsMongoId as OriginalDecorator, ValidationOptions } from 'class-validator';
import { getValidationOptions } from '../validation';
import { IsMongoIdMessage } from '../messages';

export function IsMongoId(validationOptions?: ValidationOptions): PropertyDecorator {
    return OriginalDecorator(getValidationOptions(IsMongoIdMessage, validationOptions));
}
