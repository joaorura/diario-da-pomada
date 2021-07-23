export default () => ({
    jwt: {
        privateKey: Buffer.from(process.env.PRIVATE_KEY, 'base64').toString('utf-8'),
        publicKey: Buffer.from(process.env.PUBLIC_KEY, 'base64').toString('utf-8'),
        signOptions: {
            algorithm: 'RS256',
            expiresIn: '30d',
        },
    },
});
