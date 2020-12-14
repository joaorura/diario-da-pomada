import Knex from 'knex';
import { Model } from 'objection';
import config from '@Root/knexfile';

const database = Knex(config);
Model.knex(database);

export default database;
