import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Schema as SchemaMongoose } from 'mongoose';

@Schema({ timestamps: true })
export class WeeklyQuestion {
    _id: string;
    @Prop() createdAt?: Date;
    @Prop() updatedAt?: Date;
    @Prop() tipoIncomodo: string;
    @Prop() motivoParadaUso: string;
    @Prop() tipoSujeiraCalcinha: string;
    @Prop() tipoDificuldadeSexo: string;
    @Prop() tipoCorResiduoCalcinha: string;
    @Prop() tipoMestruacaoDiferente: string;
    @Prop({ required: true }) parouUso: boolean;
    @Prop({ required: true }) dataDeMarcacao: Date;
    @Prop({ required: true }) dataMenstruacao: Date;
    @Prop({ required: true }) sentiuIncomodo: boolean;
    @Prop({ required: true }) sanguePresente: boolean;
    @Prop({ required: true }) dificuldadeSexo: boolean;
    @Prop({ required: true }) dataDePreenchimento: Date;
    @Prop({ required: true }) aplicouDormirSexo: boolean;
    @Prop({ required: true }) dificuldadeIntroducao: boolean;
    @Prop({ required: true }) menstruouRecentemente: boolean;
    @Prop({ required: true }) mestruacaoIgualAnterior: boolean;
    @Prop({ required: true, type: SchemaMongoose.Types.ObjectId }) userId: string;
}

@Schema({ timestamps: true })
export class DailyQuestion {
    _id: string;
    @Prop() createdAt?: Date;
    @Prop() updatedAt?: Date;
    @Prop() motivoNaoUsar: string;
    @Prop({ required: true }) usouPomada: boolean;
    @Prop({ required: true }) dataDeMarcacao: Date;
    @Prop({ required: true }) dataDePreenchimento: Date;
    @Prop({ required: true, type: SchemaMongoose.Types.ObjectId }) userId: string;
}

export type WeeklyQuestionDocument = WeeklyQuestion & Document;
export const WeeklyQuestionSchema = SchemaFactory.createForClass(WeeklyQuestion);

export type DailyQuestionDocument = DailyQuestion & Document;
export const DailyQuestionSchema = SchemaFactory.createForClass(DailyQuestion);
