import { registerDecorator, ValidationOptions } from 'class-validator';
import { IsStringNullMessage } from '../messages';

export function IsStringNull(validationOptions?: ValidationOptions) {
    return function (object: any, propertyName: string) {
        registerDecorator({
            constraints: [],
            name: 'IsStringNull',
            target: object.constructor,
            propertyName: propertyName,
            options: validationOptions,
            validator: {
                validate(value: any) {
                    return typeof value === 'string' || value == null;
                },
                defaultMessage() {
                    return IsStringNullMessage;
                },
            },
        });
    };
}
