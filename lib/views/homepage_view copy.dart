import 'package:flutter/material.dart';
import 'package:flutter_api_sqflite/controllers/Favorite_controller.dart';
import 'package:flutter_api_sqflite/controllers/homepage_controller.dart';
import 'package:flutter_api_sqflite/database/database_instance.dart';
import 'package:flutter_api_sqflite/models/favorite_movie_model.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../common/api_services.dart';

class FavoriteView extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      body: Obx(() {
        if (favoriteController.favorites.isEmpty) {
          return Center(child: Text('No favorite movies yet.'));
        } else {
          return ListView.builder(
            itemCount: favoriteController.favorites.length,
            itemBuilder: (context, index) {
              var movie = favoriteController.favorites[index];
              return Container(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                  leading: Image.network(
                      '${AppConstant.IMAGE_URL}${movie.posterPath}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await favoriteController.deleteFavorite(movie);
                      Get.snackbar('Success', 'Movie deleted from favorites');
                    },
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
