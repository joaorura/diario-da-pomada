import * as Knex from 'knex';
import IntroCarousel from '../models/IntroCarousel';

export function seed(knex: Knex): Promise<IntroCarousel[]> {
    return IntroCarousel.query(knex).insert([
        {
            id: 2,
            header: 'Ginecologia Inclusiva',
            imagePath: 'ginecologia-inclusiva',
            description: 'Um povo unido nunca é vencido!',
            imagePosition: 2,
            createdAt: new Date(),
            updatedAt: new Date()
        }
    ]);
}
