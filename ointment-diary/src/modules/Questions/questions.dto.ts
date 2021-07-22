import { IsBoolean, IsDateOnly, IsNotEmpty, IsStringNull } from 'src/extends/class-validator-br';

export class CreateWeeklyQuestion {
    @IsStringNull() tipoIncomodo: string;
    @IsStringNull() motivoParadaUso: string;
    @IsStringNull() tipoSujeiraCalcinha: string;
    @IsStringNull() tipoDificuldadeSexo: string;
    @IsStringNull() tipoCorResiduoCalcinha: string;
    @IsStringNull() tipoMestruacaoDiferente: string;
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
    @IsStringNull() motivoNaoUsar: string;
    @IsBoolean() @IsNotEmpty() usouPomada: boolean;
    @IsDateOnly() @IsNotEmpty() dataDeMarcacao: Date;
    @IsDateOnly() @IsNotEmpty() dataDePreenchimento: Date;
}
