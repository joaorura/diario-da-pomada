import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Schema as SchemaMongoose } from 'mongoose';

@Schema({ timestamps: true })
export class Calendary {
    _id: string;
    @Prop() createdAt?: Date;
    @Prop() updatedAt?: Date;
    @Prop({ required: true }) dueDate: Date;
    @Prop({ required: true }) daily: string[];
    @Prop({ required: true }) weekly: string[];
    @Prop({ required: true, unique: true, type: SchemaMongoose.Types.ObjectId }) userId: string;
}

export type CalendaryDocument = Calendary & Document;
export const CalendarySchema = SchemaFactory.createForClass(Calendary);
