import { HasMimeType as OriginalDecorator } from 'nestjs-form-data';
import { getValidationOptions } from '../validation';
import { ValidationOptions } from 'class-validator';
import { HasMimeTypeMessage } from '../messages';

export function HasMimeType(allowedMimeTypes: string[], validationOptions?: ValidationOptions): PropertyDecorator {
    return OriginalDecorator(allowedMimeTypes, getValidationOptions(HasMimeTypeMessage(allowedMimeTypes), validationOptions));
}
