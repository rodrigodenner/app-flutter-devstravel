import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  var list = [];

  void searchCities(BuildContext context, String searchText) async {
    AppData appData = Provider.of<AppData>(context, listen: false);
    String normalizedSearchText = searchText.trim().toLowerCase();

    if (normalizedSearchText.isEmpty) {
      setState(() {
        list = [];
      });
      return;
    }

    List<dynamic> searchResults = [];

    for (var continent in appData.data) {
      for (var country in continent['countries']) {
        for (var city in country['cities']) {
          if (city['name'].toLowerCase().contains(normalizedSearchText)) {
            searchResults.add(city);
          }
        }
      }
    }
    setState(() {
      list = searchResults;
    });
  }

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
      builder: (ctx, appdata, child) => Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          pageContext: context,
          scaffoldKey: _scaffoldKey,
          title: 'Buscar Cidade',
          hideSearch: true,
        ),
        drawer: CustomDrawer(pageContext: context),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10, right: 15, bottom: 10, left: 15),
              child: TextField(
                onChanged: (text) {
                  searchCities(context, text);
                },
                decoration: InputDecoration(
                  hintText: 'Digite o nome da cidade',
                  suffixIcon: Icon(
                    Icons.search,
                    size: 32,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: list.isEmpty
                  ? Center(
                child: Text(
                  'Nenhum resultado encontrado',
                  style: TextStyle(fontSize: 18.0),
                ),
              )
                  : GridView.count(
                crossAxisCount: 2,
                children: List.generate(list.length, (index) {
                  return CityBox(
                    data: list[index],
                    onTap: (cityData) {
                      cityBoxAction(context, cityData);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
