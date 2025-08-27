// ✅ Import for web file support
import 'dart:typed_data';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter_dropzone/flutter_dropzone.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizedBytes;
  String mediaCategory;
  final String fileName;
  final String? fullPath;
  final DateTime? createdAt;
  final bool? isActive;
  final DateTime? updatedAt;
  final String? contentType;

  // ✅ This must match the actual file type you use on Flutter Web
  final dynamic? file;

  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;

  ImageModel({
    this.id = '',
    required this.url,
    required this.folder,
    required this.fileName,
    this.sizedBytes,
    this.fullPath,
    this.createdAt,
    this.updatedAt,
    this.contentType,
    this.file,
    this.localImageToDisplay,
    this.mediaCategory = '',
    this.isActive
  });

  static ImageModel empty() => ImageModel(url: '', folder: '', fileName: '');

 factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
  id: json['id'],        // must be valid UUID string, not null
  url: json['url'],
  fileName: json['filename'],
  folder: json['folder'],
  isActive: json['is_active'],
  mediaCategory: json['mediaCategory'],
);

}
