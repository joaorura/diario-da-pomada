import { IsMongoId, IsNotEmpty } from './extends/class-validator-br';

export class DatabaseQuery {
    @IsNotEmpty()
    @IsMongoId()
    id: string;
}
