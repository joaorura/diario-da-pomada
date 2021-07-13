import { ValidationOptions } from 'class-validator';

export function getValidationOptions(message: string, validationOptions?: ValidationOptions) {
    return {
        each: validationOptions?.each,
        groups: validationOptions?.groups,
        always: validationOptions?.always,
        context: validationOptions?.context,
        message: validationOptions?.message || message,
    };
}
