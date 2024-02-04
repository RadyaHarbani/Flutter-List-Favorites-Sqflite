import 'package:get/get.dart';

import '../bindings/homepage_binding.dart';
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
  ];
}
