import 'dart:io';

class Attachment {
  final File file;
  final String base64;
  final String name;

  Attachment({required this.file, required this.base64, required this.name});
}
