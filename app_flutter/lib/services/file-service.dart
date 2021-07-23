import 'dart:io';

import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileService {
  Future<String> _nameFile(String name) async {
    String tempPath = (await getExternalStorageDirectory()).path;
    return tempPath + '/$name';
  }

  Future<void> writeFileByte(Uint8List data, String name) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    String filePath = await _nameFile(name);
    var bytes = ByteData.view(data.buffer);
    final buffer = bytes.buffer;

    return File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<void> writeFileString(String data, String name) async {
    var status = await Permission.manageExternalStorage.status;
    var otherStatus = await Permission.storage.status;

    if (status.isDenied) {
      await Permission.manageExternalStorage.request();
    }

    if (otherStatus.isDenied) {
      await Permission.storage.request();
    }

    String filePath = await _nameFile(name);
    File(filePath).writeAsStringSync(data);
  }
}
