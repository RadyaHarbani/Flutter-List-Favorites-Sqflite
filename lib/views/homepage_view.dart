import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_sqflite/common/api_services.dart';
import 'package:flutter_api_sqflite/controllers/favoritepage_controller.dart';
import 'package:flutter_api_sqflite/database/database_instance.dart';
import 'package:flutter_api_sqflite/models/favorite_movie_model.dart';
import 'package:flutter_api_sqflite/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/homepage_controller.dart';

class HomePageView extends GetView<HomePageController> {
  final controllerFavorite = Get.put(FavoritePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies Overview',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(
        () {
          return ConnectivityWidgetWrapper(
            alignment: Alignment.topCenter,
            height: 50,
            message: "You're offline, please move to the save page",
            messageStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            child: controller.isLoading.value == false
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: controller.allMovies.length,
                    itemBuilder: (context, index) {
                      var movie = controller.allMovies[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 40,
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '${AppConstant.IMAGE_URL}${movie.backdropPath}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 25,
                              right: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 140,
                                    child: Text(
                                      movie.title,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    width: 180,
                                    height: 20,
                                    child: Text(
                                      movie.overview,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        movie.voteAverage.toString(),
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: -20,
                              left: 10,
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                width: 150,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${AppConstant.IMAGE_URL}${movie.posterPath}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: IconButton(
                                onPressed: () {
                                  Get.snackbar(
                                    'Saved',
                                    '${movie.title!} has been saved to favorite',
                                    snackPosition: SnackPosition.TOP,
                                    colorText: Colors.black,
                                  );
                                  FavoriteMovie favoriteMovie = FavoriteMovie(
                                    id: movie.id,
                                    title: movie.title,
                                    overview: movie.overview,
                                    posterPath: movie.posterPath,
                                    backdropPath: movie.backdropPath,
                                    releaseDate: movie.releaseDate,
                                    voteAverage: movie.voteAverage,
                                  );
                                  DatabaseHelper()
                                      .insertFavorite(favoriteMovie);
                                },
                                icon: Icon(
                                  Icons.save_as_rounded,
                                  color: Colors.white,
                                  size: 23,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          Get.toNamed(Routes.FAVORITEPAGE);
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          child: Icon(
            Icons.favorite,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
