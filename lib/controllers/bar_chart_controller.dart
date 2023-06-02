import 'package:get/get.dart';
import 'package:library_pc/controllers/db_helper.dart';

class BarChartController extends GetxController {
  RxList<int> booksAvailibilityData = RxList<int>([0, 0, 0]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updateData();
  }

  void updateData() async {
    final data = await DBHelper.getBookAvailabilityInfo();
    booksAvailibilityData.assignAll(data);
    //print('BarChartController:$data');
  }

  static void onDataUpdated() {
    final controller = Get.find<BarChartController>();
    controller.updateData();
  }
}
