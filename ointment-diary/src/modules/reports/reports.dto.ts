import { FixedLength, IsNotEmpty, IsString } from 'src/extends/class-validator-br';

export class GetSpecificReport {
    @IsString()
    @IsNotEmpty()
    @FixedLength(15)
    healthCard: string;
}
