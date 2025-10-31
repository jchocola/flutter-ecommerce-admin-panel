import 'package:admin_panel/repositories/category_repository.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class CategoryControllerCustom extends GetxController {
  final _categoryRepo = Get.find<CategoryRepository>();

  var pickedFile = Rx<FilePickerResult?>(null);

  // uses case
  void pickImage() async {
    pickedFile.value = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    update();
  }
}
