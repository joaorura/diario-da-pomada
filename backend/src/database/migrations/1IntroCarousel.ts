import * as Knex from 'knex';

const tableName = 'intro-carousel';
export function up(knex: Knex): Knex.SchemaBuilder {
    return knex.schema.createTable(tableName, t => {
        t.increments('id').primary();
        t.string('header', 100).notNullable();
        t.timestamp('createdAt').notNullable();
        t.timestamp('updatedAt').notNullable();
        t.string('imagePath', 100).notNullable();
        t.string('description', 256).notNullable();
        t.integer('imagePosition').unsigned().notNullable();
    });
}

export function down(knex: Knex): Knex.SchemaBuilder {
    return knex.schema.dropTable(tableName);
}
