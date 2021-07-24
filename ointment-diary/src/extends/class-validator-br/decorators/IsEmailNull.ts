import { isEmail, registerDecorator, ValidationOptions } from 'class-validator';
import { IsEmailNullMessage } from '../messages';
import Validator from 'validator';

export function IsEmailNull(options?: Validator.IsEmailOptions, validationOptions?: ValidationOptions) {
    return function (object: any, propertyName: string) {
        registerDecorator({
            name: 'IsEmailNull',
            target: object.constructor,
            propertyName: propertyName,
            options: validationOptions,
            validator: {
                validate(value: string = null) {
                    if (value == null) {
                        return true;
                    }
                    if (typeof value == 'string') {
                        return isEmail(value, options);
                    }
                    return false;
                },
                defaultMessage() {
                    return IsEmailNullMessage;
                },
            },
        });
    };
}
