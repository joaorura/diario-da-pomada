import { registerDecorator, ValidationOptions } from 'class-validator';
import { IsDateOnlyNullMessage } from '../messages';
import isValid from 'date-fns/isValid';

export function IsDateOnlyNull(validationOptions?: ValidationOptions) {
    return function (object: any, propertyName: string) {
        registerDecorator({
            name: 'IsDateOnlyNull',
            target: object.constructor,
            propertyName: propertyName,
            options: validationOptions,
            validator: {
                validate(value: string = null) {
                    if (value) {
                        const date = new Date(value);
                        return isValid(date);
                    }
                    return true;
                },
                defaultMessage() {
                    return IsDateOnlyNullMessage;
                },
            },
        });
    };
}
