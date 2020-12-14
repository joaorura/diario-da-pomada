import * as Knex from 'knex';
import IntroCarousel from '../models/IntroCarousel';

export function seed(knex: Knex): Promise<IntroCarousel[]> {
    return IntroCarousel.query(knex).insert([
        {
            id: 1,
            header: 'Ginecologia Efetiva',
            imagePath: 'ginecologia-efetiva',
            description: 'Faça parte você também!',
            imagePosition: 1,
            createdAt: new Date(),
            updatedAt: new Date()
        }
    ]);
}
