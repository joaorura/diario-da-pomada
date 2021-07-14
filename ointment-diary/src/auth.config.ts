import { readFileSync } from 'fs';
import { join } from 'path';

export default () => ({
    jwt: {
        privateKey: readFileSync(join(__dirname, 'private.pem')),
        publicKey: readFileSync(join(__dirname, 'public.pem')),
        signOptions: {
            algorithm: 'RS256',
            expiresIn: '1d',
        },
    },
});
