import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static Future<StorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  Future<void> saveFavorite(String planetId) async {
    final favorites = getFavorites();
    if (!favorites.contains(planetId)) {
      favorites.add(planetId);
      await _prefs.setStringList('favorites', favorites);
    }
  }

  List<String> getFavorites() {
    return _prefs.getStringList('favorites') ?? [];
  }
}