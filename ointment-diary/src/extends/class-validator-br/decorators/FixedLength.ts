import { registerDecorator, ValidationArguments, ValidationOptions } from 'class-validator';
import { FixedLengthMessage } from '../messages';

export function FixedLength(fixedLength: number, validationOptions?: ValidationOptions) {
    return function (object: any, propertyName: string) {
        registerDecorator({
            name: 'isLongerThan',
            constraints: [fixedLength],
            target: object.constructor,
            propertyName: propertyName,
            options: validationOptions,
            validator: {
                validate(value: any, args: ValidationArguments) {
                    const [length] = args.constraints;
                    return typeof value === 'string' && value.length == length;
                },
                defaultMessage() {
                    return FixedLengthMessage;
                },
            },
        });
    };
}
