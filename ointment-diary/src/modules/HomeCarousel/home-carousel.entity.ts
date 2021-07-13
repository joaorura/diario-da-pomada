import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

@Schema({ timestamps: true })
export class HomeCarousel {
    _id: string;
    @Prop() createdAt?: Date;
    @Prop() updatedAt?: Date;
    @Prop({ required: true }) size: number;
    @Prop({ required: true }) file: string;
    @Prop({ required: true }) header: string;
    @Prop({ required: true }) encoding: string;
    @Prop({ required: true }) mimetype: string;
    @Prop({ required: true }) filename: string;
    @Prop({ required: true }) description: string;
    @Prop({ required: true }) originalName: string;
    @Prop({ required: true, unique: true }) imagePosition: number;
}

export type HomeCarouselDocument = HomeCarousel & Document;
export const HomeCarouselSchema = SchemaFactory.createForClass(HomeCarousel);

HomeCarouselSchema.pre('save', async function validateUniqueImagePosition(): Promise<void> {
    const isAlready = await this.model('HomeCarousel').exists({ imagePosition: this.get('imagePosition') });
    if (isAlready) throw new Error('Já existe uma imagem com a posição enviada. #Ref: imagePosition');
});
