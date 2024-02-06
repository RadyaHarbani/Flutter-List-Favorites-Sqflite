import 'package:flutter_api_sqflite/database/database_instance.dart';
import 'package:flutter_api_sqflite/models/favorite_movie_model.dart';
import 'package:get/get.dart';

class FavoritePageController extends GetxController {
  RxList<FavoriteMovie> favorites = <FavoriteMovie>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    var db = DatabaseHelper();
    var favoriteList = await db.getFavorites();
    favorites.assignAll(favoriteList);
  }

  Future<void> deleteFavorite(FavoriteMovie favoriteMovie) async {
    var db = DatabaseHelper();
    await db.deleteFavorite(favoriteMovie);
    favorites.remove(favoriteMovie);
  }
}
