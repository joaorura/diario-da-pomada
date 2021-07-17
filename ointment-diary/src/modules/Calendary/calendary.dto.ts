import { IsDateOnly, IsNotEmpty } from 'src/extends/class-validator-br';

export class CreateCalendary {
    @IsNotEmpty()
    currentDate: Date;
}

export class GetCalendary {
    @IsNotEmpty()
    @IsDateOnly()
    currentDate: Date;
}
