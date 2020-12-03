import 'package:app_flutter/first-carousel/text-carousel.dart';
import 'package:app_flutter/first-carousel/title-carousel.dart';
import 'package:app_flutter/models/carousel-model.dart';
import 'package:app_flutter/services/carousel-service.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_flutter/first-carousel/list-white-dot.dart';

class FirstCarousel extends StatefulWidget {
  @override
  _FirstCarouselState createState() => _FirstCarouselState();
}

class _FirstCarouselState extends State<FirstCarousel> {
  final CarouselService _carouselService = new CarouselService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: this._carouselService.getCarouselModel(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return null;
          }

          List<CarouselModel> listCarouselModel = snapshot.data;

          return CarouselSlider(
            options:
                CarouselOptions(height: double.infinity, viewportFraction: 1),
            items: listCarouselModel
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
                .toList(),
          );
        });
  }
}
