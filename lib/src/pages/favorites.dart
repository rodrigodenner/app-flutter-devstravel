import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void cityBoxAction(pageContext, cityData) {
    Navigator.pushNamed(
      pageContext,
      '/city',
      arguments: {
        'cityData': cityData,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (ctx, appdata, child) {
        List<dynamic> favoriteCities = [];
        for (var continent in appdata.data) {
          for (var country in continent['countries']) {
            for (var city in country['cities']) {
              if (appdata.favorite(city['name'])) {
                favoriteCities.add(city);
              }
            }
          }
        }
        return Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            pageContext: context,
            scaffoldKey: _scaffoldKey,
            title: 'Cidades Salvas',
            hideSearch: true,
          ),
          drawer: CustomDrawer(pageContext: context),
          backgroundColor: Colors.white,
          body: favoriteCities.isEmpty
              ? Center(
            child: Text(
              'Nenhuma cidade salva',
              style: TextStyle(fontSize: 18.0),
            ),
          )
              : GridView.count(
            crossAxisCount: 2,
            children: List.generate(favoriteCities.length, (index) {
              return CityBox(
                data: favoriteCities[index],
                onTap: (cityData) {
                  cityBoxAction(context, cityData);
                },
              );
            }),
          ),
        );
      },
    );
  }
}
