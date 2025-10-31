import 'dart:io';

import 'package:admin_panel/main.dart';
import 'package:admin_panel/util/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart';

class CategoryRepository {
  final categoryRef = FirebaseFirestore.instance.collection('Categories');
  final storageRef = FirebaseStorage.instance.ref().child('Categories');

  Future<void> addCategory(CustomCategoryModel category) async {
    try {
      await categoryRef.doc(category.id).set(category.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadImage({
    required String categoryId,
    required PlatformFile file,
  }) async {
    try {
      var imagePath = '${categoryId}.jpg';
      final data = file.bytes;
      var snapshot = await storageRef.child(imagePath).putData(data!, SettableMetadata(contentType: 'image/jpg'));
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
