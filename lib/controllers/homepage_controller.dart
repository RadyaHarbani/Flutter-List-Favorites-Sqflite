import 'dart:convert';

import 'package:flutter_api_sqflite/models/all_movie_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../common/api_services.dart';
import '../models/favorite_movie_model.dart';

class HomePageController extends GetxController {
  RxBool isLoading = true.obs;
  RxList allMovies = [].obs;

  @override
  void onInit() {
    super.onInit();
    getAllMovies();
  }

  Future getAllMovies() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('${AppConstant.BASE_URL}${AppConstant.ENDPOINT_TRENDING}'),
      );
      if (response.statusCode == 200) {
        isLoading(false);
        final content = json.decode(response.body)['results'];
        for (var item in content) {
          allMovies.add(Results.fromJson(item));
        }
      } else {
        print("Failed to load data!");
      }
    } catch (e) {
      print(e);
    }
  }

}
