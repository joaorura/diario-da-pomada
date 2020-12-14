import path from 'path';
import imports from '../../general/imports';
import { loadFilesSync } from '@graphql-tools/load-files';
import { makeExecutableSchema } from '@graphql-tools/schema';
import { mergeTypeDefs, mergeResolvers } from '@graphql-tools/merge';

const dirname = path.dirname(__dirname);
const typeDefsRegex = '/**/types/*.graphql';
const typeDefsPaths = path.join(dirname, typeDefsRegex);
const typeDefsLoaded = loadFilesSync(typeDefsPaths);
const typeDefsMerged = mergeTypeDefs([...typeDefsLoaded, ...imports.typeDefs]);

const resolversDefsRegex = '/**/resolvers/*.ts';
const resolversDefsPaths = path.join(dirname, resolversDefsRegex);
const resolversDefsLoaded = loadFilesSync(resolversDefsPaths);
const resolversDefsMerged = mergeResolvers([...resolversDefsLoaded, ...imports.resolverDefs]);

export default makeExecutableSchema({
    typeDefs: typeDefsMerged,
    resolvers: resolversDefsMerged
});
