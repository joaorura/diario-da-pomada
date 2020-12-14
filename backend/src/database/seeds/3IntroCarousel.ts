import * as Knex from 'knex';
import IntroCarousel from '../models/IntroCarousel';

export function seed(knex: Knex): Promise<IntroCarousel[]> {
    return IntroCarousel.query(knex).insert([
        {
            id: 3,
            header: 'Ginecologia Simplificada',
            imagePath: 'ginecologia-simplificada',
            description: 'Faça em casa!',
            imagePosition: 3,
            createdAt: new Date(),
            updatedAt: new Date()
        }
    ]);
}
