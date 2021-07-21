import { IsBoolean, IsDateOnly, IsNotEmpty, IsString } from 'src/extends/class-validator-br';

export class CreateWeeklyQuestion {
    @IsString() tipoIncomodo: string;
    @IsString() motivoParadaUso: string;
    @IsString() tipoSujeiraCalcinha: string;
    @IsString() tipoDificuldadeSexo: string;
    @IsString() tipoCorResiduoCalcinha: string;
    @IsString() tipoMestruacaoDiferente: string;
    @IsBoolean() @IsNotEmpty() parouUso: boolean;
    @IsDateOnly() @IsNotEmpty() dataDeMarcacao: Date;
    @IsDateOnly() @IsNotEmpty() dataMenstruacao: Date;
    @IsBoolean() @IsNotEmpty() sentiuIncomodo: boolean;
    @IsBoolean() @IsNotEmpty() sanguePresente: boolean;
    @IsBoolean() @IsNotEmpty() dificuldadeSexo: boolean;
    @IsDateOnly() @IsNotEmpty() dataDePreenchimento: Date;
    @IsBoolean() @IsNotEmpty() aplicouDormirSexo: boolean;
    @IsBoolean() @IsNotEmpty() dificuldadeIntroducao: boolean;
    @IsBoolean() @IsNotEmpty() menstruouRecentemente: boolean;
    @IsBoolean() @IsNotEmpty() mestruacaoIgualAnterior: boolean;
}

export class CreateDailyQuestion {
    @IsString() motivoNaoUsar: string;
    @IsBoolean() @IsNotEmpty() usouPomada: boolean;
    @IsDateOnly() @IsNotEmpty() dataDeMarcacao: Date;
    @IsDateOnly() @IsNotEmpty() dataDePreenchimento: Date;
}
