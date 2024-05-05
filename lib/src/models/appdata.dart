import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppData with ChangeNotifier {
  var data = [];

  void setData(newData) {
    data = newData;
    notifyListeners();
  }

  Future<bool> requestData() async {
    final res = await http.get(Uri.parse('https://api.b7web.com.br/flutter1wb/'));

    if (!(res.statusCode == 200)) {
      print('Request failed');
      return false;
    }

    setData(json.decode(res.body));
    return true;
  }
}
