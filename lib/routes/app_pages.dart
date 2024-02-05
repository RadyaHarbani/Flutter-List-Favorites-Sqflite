import 'package:get/get.dart';

import '../bindings/favoritepage_binding.dart';
import '../bindings/homepage_binding.dart';
import '../views/favoritepage_view.dart';
import '../views/homepage_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOMEPAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITEPAGE,
      page: () => FavoritePageView(),
      binding: FavoritePageBinding(),
    ),
  ];
}
