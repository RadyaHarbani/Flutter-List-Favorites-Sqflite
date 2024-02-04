import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/favorite_movie_model.dart';

class DatabaseHelper {
  static const String databaseName = 'favorite.db';
  static const int databaseVersion = 1;

  final String favoriteTable = 'favorite_table';
  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnOverview = 'overview';
  final String columnPosterPath = 'posterPath';

  RxList<FavoriteMovie> favorites = <FavoriteMovie>[].obs;

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    var database =
        await openDatabase(path, version: databaseVersion, onCreate: _createDb);
    return database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $favoriteTable (
        $columnId INTEGER PRIMARY KEY,
        $columnTitle TEXT,
        $columnOverview TEXT,
        $columnPosterPath TEXT
      )
    ''');
    newVersion = databaseVersion;
  }

  Future<List<FavoriteMovie>> getFavorites() async {
    final db = await initializeDatabase();
    List<Map<String, dynamic>> maps = await db.query(favoriteTable);

    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        favorites.add(FavoriteMovie.fromMap(maps[i]));
      }
    }
    return favorites;
  }

  Future<int> insertFavorite(FavoriteMovie favoriteMovie) async {
    final db = await initializeDatabase();
    var result = await db.insert(favoriteTable, favoriteMovie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<int> deleteFavorite(FavoriteMovie favoriteMovie) async {
    final db = await initializeDatabase();
    int result = await db.delete(favoriteTable,
        where: '$columnId = ?', whereArgs: [favoriteMovie.id]);

    // Remove the deleted movie from the 'favorites' list
    favorites.remove(favoriteMovie);

    return result;
  }
}
