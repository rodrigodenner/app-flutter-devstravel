import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class ListCityPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void cityBoxAction(cityData) {
    print(cityData['name']);
  }

  @override
  Widget build(BuildContext context) {
    final continentIndex = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final int? index = continentIndex?['continentIndex'] as int?;

    return Consumer<AppData>(
      builder: (ctx, appdata, child) {
        var cities = [];
        if (index != null) {
          for (var country in appdata.data[index]['countries']) {
            cities.addAll(country['cities']);
          }
        }
        return Scaffold(
          key: _scaffoldKey,
          appBar: CustomAppBar(
            pageContext: context,
            scaffoldKey: _scaffoldKey,
            title: "${index != null ? appdata.data[index]['name'] : 'Unknown'} (${cities.length} cidades)",
            hideSearch: false,
            showDrawer: true,
            showBack: true,
          ),
          drawer: CustomDrawer(
            pageContext: context,
          ),
          backgroundColor: Colors.white,
          body: GridView.count(
            crossAxisCount: 3,
            children: List.generate(cities.length, (index) {
              return CityBox(
                data: cities[index],
                onTap: cityBoxAction,
              );
            }),
          ),
        );
      },
    );
  }
}
