import { MaxFileSize as OriginalDecorator } from 'nestjs-form-data';
import { getValidationOptions } from '../validation';
import { ValidationOptions } from 'class-validator';
import { MaxFileSizeMessage } from '../messages';

export function MaxFileSize(maxSizeBytes: number, validationOptions?: ValidationOptions): PropertyDecorator {
    return OriginalDecorator(maxSizeBytes, getValidationOptions(MaxFileSizeMessage, validationOptions));
}
