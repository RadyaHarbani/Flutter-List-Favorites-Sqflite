import 'package:flutter/material.dart';
import 'package:flutter_api_sqflite/common/api_services.dart';
import 'package:flutter_api_sqflite/views/homepage_view%20copy.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/homepage_controller.dart';
import '../database/database_instance.dart';
import '../models/favorite_movie_model.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie e-catalogue',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(FavoriteView());
            },
            icon: Icon(Icons.favorite),
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: controller.allMovies.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: ListTile(
                    title: Text(controller.allMovies[index].title),
                    subtitle: Text(controller.allMovies[index].overview),
                    leading: Image.network(
                      '${AppConstant.IMAGE_URL}${controller.allMovies[index].posterPath}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {
                        FavoriteMovie favoriteMovie = FavoriteMovie(
                          id: controller.allMovies[index].id!,
                          title: controller.allMovies[index].title!,
                          overview: controller.allMovies[index].overview!,
                          posterPath: controller.allMovies[index].posterPath!,
                        );
                        DatabaseHelper().insertFavorite(favoriteMovie);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
