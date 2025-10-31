import 'dart:io';

import 'package:admin_panel/main.dart';
import 'package:admin_panel/repositories/category_repository.dart';
import 'package:admin_panel/util/models/category_model.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class CategoryControllerCustom extends GetxController {
  final _categoryRepo = Get.find<CategoryRepository>();

  var pickedFile = Rx<FilePickerResult?>(null);

  /// image file
  var categoryList = <CustomCategoryModel>[].obs;

  /// list of categories
  var isLoading = false.obs;

  /// loading state
  var editingCategory = CustomCategoryModel().obs;

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  // uses case
  void pickImage() async {
    pickedFile.value = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    update();
  }

  Future<void> createCategory({required CustomCategoryModel category}) async {
    try {
      isLoading.value = true;
      await _categoryRepo.addCategory(category);

      // reload categories
      getAllCategories();
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> uploadImageandGetUrl({required String categoryId}) async {
    logger.i('Uploading image for category $categoryId');
    try {
      isLoading.value = true;
      return await _categoryRepo.uploadImage(
        categoryId: categoryId,
        file: pickedFile.value!.files[0],
      );
    } catch (e) {
      logger.e(e);
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllCategories() async {
    try {
      logger.i('Getting all categories');
      isLoading.value = true;
      categoryList.value = await _categoryRepo.getCategories();
    } catch (e) {
      logger.e('Error getting categories');
      logger.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCategory({required String categoryId}) async {
    try {
      logger.i('Deleting category $categoryId');
      isLoading.value = true;
      // delete image from storage
      await _categoryRepo.deleteImage(ref: '${categoryId}.jpg');

      // delete category
      await _categoryRepo.deleteCategory(categoryId: categoryId);
      // reload categories
      getAllCategories();
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  void setEditingCategory(CustomCategoryModel category) {
    editingCategory.value = category;
  }

  void clearPickedFile() {
    pickedFile.value = null;
  }

  Future<void> updateCategory({required CustomCategoryModel category}) async {
    try {
      logger.i('Updating category ${category.id}');
      CustomCategoryModel categoryWithNewData = category;
     

     ///
     /// NEW 
     ///
      if (pickedFile.value != null) {
        // delete old image
        // get old image ref
        final ref = '${category.id}.jpg';
        logger.i('Deleting old image ${ref}');
        // delete old image
        await _categoryRepo.deleteImage(ref: ref);

        // upload new image
        logger.i('Uploading new image');
        final newImageUrl = await uploadImageandGetUrl(
          categoryId: category.id!,
        );

        // update category with new image url
        categoryWithNewData = category.copyWith(imageUrl: newImageUrl);
      }

      isLoading.value = true;
      await _categoryRepo.updateCategory(category: categoryWithNewData);
      // reload categories
      getAllCategories();
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.value = false;
    }
  }
}
