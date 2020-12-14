import IntroCarousel from '@Models/IntroCarousel';

const getIntroCarousel: Resolver = (): Promise<IntroCarousel[]> => {
    return IntroCarousel.getIntroCarousel();
};

export default getIntroCarousel;
