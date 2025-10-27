import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';


class ProcessingFeeCalcController extends GetxController{
  static ProcessingFeeCalcController get instance => Get.find();


Future<String?> getProcessingFeeStructure() async {
  //final supabase = Supabase.instance.client;

  try {
//     final check = await supabase
//         .from('app_config')
//         .select('value')
//         .eq('title', 'Processing Fee Structure')
//         .maybeSingle();

//     print('🟢 Supabase check result: $check');

// return check?['value'].toString().toLowerCase();
  } catch (e) {
    print('🔴 Error fetching review config: ${e.toString()}');
    return 'include';
  }
}

}