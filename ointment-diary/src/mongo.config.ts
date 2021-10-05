export default () => ({
    mongo: {
        uri: process.env.MONGODB_URI,
        options: {
            useUnifiedTopology: true,
            useFindAndModify: false,
            useNewUrlParser: true,
            useCreateIndex: true,
        },
    },
});
