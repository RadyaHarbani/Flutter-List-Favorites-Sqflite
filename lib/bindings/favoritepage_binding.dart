import 'package:flutter_api_sqflite/controllers/favoritepage_controller.dart';
import 'package:get/get.dart';

class FavoritePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritePageController>(
      () => FavoritePageController(),
    );
  }
}
