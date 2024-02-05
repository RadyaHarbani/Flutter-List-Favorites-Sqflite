part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOMEPAGE = _Paths.HOMEPAGE;
  static const FAVORITEPAGE = _Paths.FAVORITEPAGE;
  
}

abstract class _Paths {
  _Paths._();
  static const HOMEPAGE = '/homepage';
  static const FAVORITEPAGE = '/favoritepage';
  
}
