import { GraphQLSchema } from 'graphql';
import { graphqlHTTP } from 'express-graphql';

function use(schema: GraphQLSchema, graphiql: boolean) {
    return graphqlHTTP({ schema, graphiql });
}

export default {
    use
};
