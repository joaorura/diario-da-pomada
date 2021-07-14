import { IsEmail as OriginalDecorator, ValidationOptions } from 'class-validator';
import { getValidationOptions } from '../validation';
import { IsEmailMessage } from '../messages';
import Validator from 'validator';

export function IsEmail(options?: Validator.IsEmailOptions, validationOptions?: ValidationOptions): PropertyDecorator {
    return OriginalDecorator(options, getValidationOptions(IsEmailMessage, validationOptions));
}
