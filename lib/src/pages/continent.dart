import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class ContinentPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void seeCityAction(context, continentIndex) {
    Navigator.pushReplacementNamed(
      context,
      '/listcity',
      arguments: {
        'continentIndex': continentIndex,
      },
    );
  }

  void cityBoxAction(cityData) {
    print(cityData['name']);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(
      builder: (ctx, appdata, child) => Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          pageContext: context,
          scaffoldKey: _scaffoldKey,
          title: 'Escolha um continente',
          hideSearch: false,
          showDrawer: true,
        ),
        drawer: CustomDrawer(
          pageContext: context,
        ),
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: appdata.data.length,
          itemBuilder: (context, index) {
            var cities = [];
            for (var country in appdata.data[index]['countries']) {
              cities.addAll(country['cities']);
            }

            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        "${appdata.data[index]['name']} (${cities.length})",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Helvetica Neue',
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        seeCityAction(context, index);
                      },
                      child: Text('Ver cidades',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helvetica Neue',
                          )),
                    ),
                  ],
                ),
                Container(
                  height: 150,
                  margin: EdgeInsets.only(bottom: 15),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cities.length,
                    itemBuilder: (cityContext, cityIndex) {
                      return CityBox(
                        data: cities[cityIndex],
                        onTap: cityBoxAction,
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
