import 'package:get/get.dart';
import 'package:library_pc/controllers/db_helper.dart';

class PieChartController extends GetxController {
  RxList<Map<String, dynamic>> genreData = RxList<Map<String, dynamic>>([]);
  RxBool isEmpty = RxBool(false);
  RxBool isLoading = RxBool(true);

  @override
  void onInit() {
    super.onInit();
    updateData();
  }

  void updateData() async {
    final data = await DBHelper.getGenreList();
    genreData.assignAll(data);
    isEmpty.value = genreData.isEmpty;
    isLoading.value = false;
    //print('PieChartController:$data');
  }

  static void onDataUpdated() {
    final controller = Get.find<PieChartController>();
    controller.updateData();
  }
}
