import BaseModelDate from './BaseModelDate';

class IntroCarousel extends BaseModelDate {
    id: number;
    header: string;
    imagePath: string;
    description: string;
    imagePosition: number;
    static tableName = 'intro-carousel';
    static async getIntroCarousel(): Promise<IntroCarousel[]> {
        return await IntroCarousel.query().select(['*']);
    }
}

export default IntroCarousel;
