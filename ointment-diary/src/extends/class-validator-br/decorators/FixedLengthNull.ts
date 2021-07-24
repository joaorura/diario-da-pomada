import { registerDecorator, ValidationArguments, ValidationOptions } from 'class-validator';
import { FixedLengthNullMessage } from '../messages';

export function FixedLengthNull(fixedLength: number, validationOptions?: ValidationOptions) {
    return function (object: any, propertyName: string) {
        registerDecorator({
            name: 'FixedLengthNull',
            constraints: [fixedLength],
            target: object.constructor,
            propertyName: propertyName,
            options: validationOptions,
            validator: {
                validate(value: any, args: ValidationArguments) {
                    if (value == null) {
                        return true;
                    }
                    if (typeof value === 'string') {
                        const [length] = args.constraints;
                        return value.length == length;
                    }
                    return false;
                },
                defaultMessage() {
                    return FixedLengthNullMessage;
                },
            },
        });
    };
}
