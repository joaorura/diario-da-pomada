import 'package:app_flutter/first-carousel/text-carousel.dart';
import 'package:app_flutter/first-carousel/title-carousel.dart';
import 'package:app_flutter/login-page/login-page.dart';
import 'package:app_flutter/models/carousel-model.dart';
import 'package:app_flutter/services/carousel-service.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_flutter/first-carousel/list-white-dot.dart';

class FirstCarousel extends StatefulWidget {
  @override
  _FirstCarouselState createState() => _FirstCarouselState();
}

class _FirstCarouselState extends State<FirstCarousel> {
  final CarouselService _carouselService = new CarouselService();

  Function checkIndex(int size) {
    return (int index, CarouselPageChangedReason reason) {
      if (index == size) {
        goPageWithoutBack(context, () => LoginPage())();
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: this._carouselService.getCarouselModel(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return null;
          }

          List<CarouselModel> listCarouselModel = snapshot.data;
          List<Widget> list = listCarouselModel
              .asMap()
              .map((key, value) {
                return MapEntry(key, Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: value.image, fit: BoxFit.cover),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleCarousel(text: value.title),
                            TextCarousel(text: value.textCamp),
                            ListWhiteDot(
                                whiteIndex: key, size: snapshot.data.length)
                          ],
                        ));
                  },
                ));
              })
              .values
              .toList();
          list.add(Builder(
            builder: (BuildContext context) => Container(),
          ));
          return CarouselSlider(
              options: CarouselOptions(
                  onPageChanged: this.checkIndex(list.length - 1),
                  height: double.infinity,
                  viewportFraction: 1,
                  enableInfiniteScroll: false),
              items: list);
        });
  }
}
