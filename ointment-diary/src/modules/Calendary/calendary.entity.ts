import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Schema as SchemaMongoose } from 'mongoose';

@Schema({ timestamps: true })
export class Calendary {
    _id: string;
    @Prop() createdAt?: Date;
    @Prop() updatedAt?: Date;
    @Prop({ required: true }) dueDate: Date;
    @Prop({ required: true, type: SchemaMongoose.Types.Mixed }) dates: any;
    @Prop({ required: true, unique: true, type: SchemaMongoose.Types.ObjectId }) userId: string;
}

export type CalendaryDocument = Calendary & Document;
export const CalendarySchema = SchemaFactory.createForClass(Calendary);
