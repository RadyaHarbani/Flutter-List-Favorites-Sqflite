import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_sqflite/controllers/favoritepage_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/api_services.dart';

class FavoritePageView extends GetView<FavoritePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Movies',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ConnectivityWidgetWrapper(
        alignment: Alignment.bottomCenter,
        height: 50,
        message: "Check the connection to see the image",
        messageStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        child: FutureBuilder(
          future: controller.fetchFavorites(),
          builder: (context, snapshot) {
            if (controller.favorites.isEmpty) {
              return Center(child: Text('No list movies yet'));
            } else {
              return Obx(() => ListView.builder(
                    itemCount: controller.favorites.length,
                    itemBuilder: (context, index) {
                      var favorite = controller.favorites[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 15,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '${AppConstant.IMAGE_URL}${favorite.backdropPath}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                            Positioned(
                              bottom: 40,
                              left: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          favorite.title,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Container(
                                          width: 280,
                                          child: Text(
                                            favorite.overview,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 50,
                              right: 10,
                              child: IconButton(
                                onPressed: () {
                                  Get.dialog(
                                    AlertDialog(
                                      title: Text('Remove from favorite?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            controller.deleteFavorite(favorite);
                                            Get.back();
                                          },
                                          child: Text('Yes'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('No'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.delete_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ));
            }
          },
        ),
      ),
    );
  }
}
