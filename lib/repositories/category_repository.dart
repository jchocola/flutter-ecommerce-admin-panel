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
      var snapshot = await storageRef
          .child(imagePath)
          .putData(data!, SettableMetadata(contentType: 'image/jpg'));
      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<List<CustomCategoryModel>> getCategories() async {
    try {
      var snapshot = await categoryRef.get();
      var categories =
          snapshot.docs
              .map((e) => CustomCategoryModel.fromMap(e.data()))
              .toList();
      return categories;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> deleteCategory({required String categoryId}) async {
    try {
      await categoryRef.doc(categoryId).delete();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }


  Future<void> updateCategory({required CustomCategoryModel category}) async {
    try {

      //  update category
      await categoryRef.doc(category.id).update(category.toMap());

    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<String?> getRefViaDownloadUrl(String url) async {
    try {
      var snapshot = FirebaseStorage.instance.refFromURL(url);
      return snapshot.fullPath;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> deleteImage({required String ref}) async {
    try {
      await storageRef.child(ref).delete();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
