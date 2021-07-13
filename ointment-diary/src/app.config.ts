import { MongooseModuleOptions } from '@nestjs/mongoose';

export const mongoOptions: MongooseModuleOptions = {
    useUnifiedTopology: true,
    useFindAndModify: false,
    useNewUrlParser: true,
    useCreateIndex: true,
};

export const MONGODB_URI = 'mongodb://localhost/gynecology';
