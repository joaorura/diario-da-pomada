import { registerDecorator, ValidationOptions } from 'class-validator';
import { IsDateOnlyMessage } from '../messages';
import isValid from 'date-fns/isValid';

export function IsDateOnly(validationOptions?: ValidationOptions) {
    return function (object: any, propertyName: string) {
        registerDecorator({
            name: 'IsDateOnly',
            target: object.constructor,
            propertyName: propertyName,
            options: validationOptions,
            validator: {
                validate(value: string) {
                    const date = new Date(value);
                    return isValid(date);
                },
                defaultMessage() {
                    return IsDateOnlyMessage;
                },
            },
        });
    };
}
