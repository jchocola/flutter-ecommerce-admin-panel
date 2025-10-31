import 'dart:io';

import 'package:admin_panel/main.dart';
import 'package:admin_panel/repositories/category_repository.dart';
import 'package:admin_panel/util/models/category_model.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class CategoryControllerCustom extends GetxController {
  final _categoryRepo = Get.find<CategoryRepository>();

  var pickedFile = Rx<FilePickerResult?>(null);
  var categoryList = <CustomCategoryModel>[].obs;
  var isLoading = false.obs;

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
}
