import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AppData with ChangeNotifier {
  var data = [];
  List<String> favorites = [];

  Future<void> setData(newData) async {
    data = newData;
    notifyListeners();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favorites = prefs.getStringList('favorites') ?? [];
  }

  Future<void> saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favorites);
  }

  bool favorite(String cityName) {
    return favorites.contains(cityName);
  }

  Future<void> toggleFavorite(String cityName) async {
    if (favorite(cityName)) {
      favorites.remove(cityName);
    } else {
      favorites.add(cityName);
    }
    await saveFavorites();
    notifyListeners();
  }

  Future<bool> requestData() async {
    final res = await http.get(Uri.parse('https://api.b7web.com.br/flutter1wb/'));

    if (!(res.statusCode == 200)) {
      print('Request failed');
      return false;
    }

    await setData(json.decode(res.body));
    return true;
  }
}
