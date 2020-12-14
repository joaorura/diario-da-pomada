import '@Database/database';
import morgan from 'morgan';
import express from 'express';
import graph from '@GraphQL/graph';
import modules from '@Modules/modules';

const app = express();
app.use(morgan('dev'));

// Routes
app.use('/public', graph.use(modules.publicModules, true));
app.use('/private', graph.use(modules.privateModules, true));

export default app;
