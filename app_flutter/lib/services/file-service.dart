import 'dart:io';

import 'dart:typed_data';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileService {
  Future<String> _nameFile(String name) async {
    Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
    String tempPath = tempDir.path;
    return tempPath + '/$name';
  }

  Future<File> writeFileByte(Uint8List data, String name) async {
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

  Future<File> writeFileString(String data, String name) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    String filePath = await _nameFile(name);

    return File(filePath).writeAsString(data);
  }
}
