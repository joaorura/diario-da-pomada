class FileModel {
  String fileBase64;

  FileModel.fromJson(Map<String, dynamic> json) : fileBase64 = json['file'];
}
