import path from 'path';
import { loadFilesSync } from 'graphql-tools';

const typeDefs = loadFilesSync(path.join(__dirname, '/**/types/*.graphql'));
const resolverDefs = loadFilesSync(path.join(__dirname, '/**/resolvers/*.ts'));

export default {
    typeDefs,
    resolverDefs
};
