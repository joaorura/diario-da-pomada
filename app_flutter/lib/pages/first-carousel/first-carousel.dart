import 'package:app_flutter/pages/first-carousel/text-carousel.dart';
import 'package:app_flutter/pages/first-carousel/title-carousel.dart';
import 'package:app_flutter/pages/login-page/login-page.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_flutter/pages/first-carousel/list-white-dot.dart';

class FirstCarousel extends StatefulWidget {
  final NotificationService notificationService;
  FirstCarousel(this.notificationService, {Key key}) : super(key: key);

  @override
  _FirstCarouselState createState() => _FirstCarouselState();
}

class _FirstCarouselState extends State<FirstCarousel> {
  Function checkIndex(int size) {
    return (int index, CarouselPageChangedReason reason) {
      if (index == size) {
        goPageWithoutBack(
            context, () => LoginPage(widget.notificationService))();
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
            onPageChanged: this.checkIndex(3),
            height: double.infinity,
            viewportFraction: 1,
            enableInfiniteScroll: false),
        items: [
          Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets\\images\\img_0.png"),
                      fit: BoxFit.cover),
                  color: Colors.white),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: TitleCarousel(text: ""),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: TextCarousel(text: ""),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: ListWhiteDot(whiteIndex: 0, size: 3))
                  ])),
          Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets\\images\\img_1.png"),
                      fit: BoxFit.cover),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child:
                        TitleCarousel(text: "Cuidando de você todos os dias!"),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: TextCarousel(
                        text: "Você é importante e merece cuidado."),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ListWhiteDot(whiteIndex: 1, size: 3))
                ],
              )),
          Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets\\images\\img_2.png"),
                      fit: BoxFit.cover),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: TitleCarousel(text: "Cuide-se"),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: TextCarousel(
                        text: "A nossa saúde é um dos nossos maiores bens."),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ListWhiteDot(whiteIndex: 2, size: 3))
                ],
              )),
          Container()
        ]);
  }
}
