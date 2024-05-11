import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';

class CityPage extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  TextStyle styles = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    fontFamily: 'Helvetica Neue',
  );

  @override
  Widget build(BuildContext context) {
    var cityData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Consumer<AppData>(
      builder: (ctx, appdata, child) => Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawer(pageContext: context),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            Container(
                height: 50,
                margin: EdgeInsets.only(top: statusBarHeight, left: 10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.white, size: 30),
                  onPressed: () {},
                )),
            ListView(
              physics: ClampingScrollPhysics(),
              padding:EdgeInsets.zero,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 220),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40),

                  ),
                  child: Container(
                    height: 1000,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
