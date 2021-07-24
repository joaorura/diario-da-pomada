import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import bcrypt from 'bcrypt';

@Schema({ timestamps: true })
export class User {
    _id: string;
    @Prop({ select: false }) __v?: number;
    @Prop({ default: null }) email: string;
    @Prop({ select: false }) createdAt?: Date;
    @Prop({ select: false }) updatedAt?: Date;
    @Prop({ required: true }) birthDate: Date;
    @Prop({ required: true }) fullName: string;
    @Prop({ default: null }) nationalCard: string;
    @Prop({ required: true, default: 'user' }) role: string;
    @Prop({ required: true, select: false }) password: string;
    @Prop({ required: true, unique: true }) healthCard: string;
    @Prop({ required: true, default: 0, select: false }) attempts: number;
}

export type UserDocument = User & Document;
export const UserSchema = SchemaFactory.createForClass(User);

UserSchema.methods.comparePassword = async function (password: string): Promise<boolean> {
    return await bcrypt.compare(password, this.get('password'));
};

UserSchema.pre('save', async function (): Promise<void> {
    const self: any = this;

    if (self.get('nationalCard') != null) {
        await uniqueFieldValidation(self.model('User'), 'nationalCard', self.get('nationalCard'));
    }

    if (self.get('email')) {
        await uniqueFieldValidation(self.model('User'), 'email', self.get('email'));
    }

    await uniqueFieldValidation(self.model('User'), 'healthCard', self.get('healthCard'));
    if (self.isModified('password')) {
        self.password = await encryption(self.password);
    }
});

UserSchema.pre('findByIdAndUpdate', async function (): Promise<void> {
    const self: any = this;
    const document: any = this.getUpdate();

    if (document.nationalCard != null) {
        await uniqueFieldValidation(self.model, 'nationalCard', document.nationalCard, document.id);
    }

    if (document.email != null) {
        await uniqueFieldValidation(self.model, 'email', document.email, document.id);
    }

    await uniqueFieldValidation(self.model, 'healthCard', document.healthCard, document.id);
    if (document.password) {
        const password = await encryption(document.password);
        this.update({}, { password });
    }
});

async function uniqueFieldValidation(model, field: string, fieldValue: string, id?: string) {
    const filters = id ? { _id: { $ne: id } } : {};
    const isAlready = await model.exists({ [field]: fieldValue, ...filters });
    if (isAlready) throw new Error(`Esse documento já está cadastrado. #Ref: ${field}`);
}

async function encryption(password: string) {
    const salt = await bcrypt.genSalt(14).catch(() => {
        throw new Error('Erro ao criptografar a senha enviada. #Ref: password');
    });

    return await bcrypt.hash(password, salt).catch(() => {
        throw new Error('Erro ao criptografar a senha enviada. #Ref: password');
    });
}
