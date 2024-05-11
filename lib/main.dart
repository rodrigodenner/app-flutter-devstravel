import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/models/appdata.dart';
import 'src/pages/searchpage.dart';
import 'src/pages/continent.dart';
import 'src/pages/listcity.dart';
import 'src/pages/city.dart';

// pages
import 'src/pages/preloader.dart';
import 'src/pages/home.dart';


void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AppData(),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/preloader': (context) => PreloadPage(),
        '/home': (context) => HomePage(),
        '/search':(context) => SearchPage(),
        '/continent': (context) => ContinentPage(),
        '/listcity': (context) => ListCityPage(),
        '/city': (context) => CityPage(),
      },
      initialRoute: '/preloader',
    );
  }
}






