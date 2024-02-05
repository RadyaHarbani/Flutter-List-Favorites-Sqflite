import 'package:flutter/material.dart';
import 'package:flutter_api_sqflite/controllers/favoritepage_controller.dart';
import 'package:get/get.dart';
import '../common/api_services.dart';

class FavoritePageView extends GetView<FavoritePageController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return Center(child: Text('No favorite movies yet.'));
        } else {
          return ListView.builder(
            itemCount: controller.favorites.length,
            itemBuilder: (context, index) {
              var movie = controller.favorites[index];
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
                      await controller.deleteFavorite(movie);
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
