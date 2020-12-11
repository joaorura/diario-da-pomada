import 'dart:typed_data';

import 'package:app_flutter/services/dio-service.dart';
import 'package:app_flutter/models/carousel-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<MemoryImage> readFileByte(String filePath) async {
  ByteData byteData = await rootBundle.load(filePath);
  Uint8List byteList = byteData.buffer.asUint8List();

  return MemoryImage(byteList);
}

class CarouselService extends DioService {
  Future<List<CarouselModel>> getCarouselModel() async {
    List<CarouselModel> list = new List<CarouselModel>();

    list.add(new CarouselModel(
        "", "", await readFileByte("assets\\images\\img_0.png")));

    list.add(new CarouselModel(
        "Title 1",
        "Tdsdadassdasdasdasdasdsadasdqwwqe dsdad 1",
        await readFileByte("assets\\images\\img_1.png")));

    list.add(new CarouselModel(
        "Title 2",
        "Tdsdadassdasdasdasdasdsadasdqwwqe dsdad 2",
        await readFileByte("assets\\images\\img_2.png")));
    return list;
  }
}
