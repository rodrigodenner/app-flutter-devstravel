import 'package:flutter/material.dart';
import '../partials/customdrawer.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';

class CityPage extends StatefulWidget {
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  bool heart = false;

  void heartAction() {
    setState(() {
      heart = !heart;
    });
  }

  void backButtonAction(BuildContext context) {
    Navigator.pop(context);
  }

  List<Widget> calculateStarRating(double review) {
    int fullStars = review.floor();
    double remainder = review - fullStars;
    List<Widget> stars = [];

    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: Colors.blue, size: 16));
    }

    if (remainder >= 0.5) {
      stars.add(Icon(Icons.star_half, color: Colors.blue, size: 16));
    }

    int emptyStars = 5 - fullStars - (remainder >= 0.5 ? 1 : 0);
    for (int i = 0; i < emptyStars; i++) {
      stars.add(Icon(Icons.star_border, color: Colors.grey, size: 16));
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null || !args.containsKey('cityData')) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Erro'),
        ),
        body: Center(
          child: Text('Erro ao carregar os dados da cidade.'),
        ),
      );
    }
    final cityData = args['cityData'];
    final double review = double.tryParse(cityData['review'] ?? '0') ?? 0;

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(pageContext: context),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250,
            child: Image.network(
              cityData['places'][0]['img'],
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 220),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  cityData['name'],
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Helvetica Neue',
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  ...calculateStarRating(review),
                                  SizedBox(width: 5),
                                  Text(
                                    cityData['review'],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Helvetica Neue',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: IconButton(
                            icon: Consumer<AppData>(
                              builder: (context, appData, _) => Icon(
                                appData.favorite(cityData['name']) ? Icons.favorite : Icons.favorite_border,
                                color: Colors.red,
                              ),
                            ),
                            onPressed: () {
                              heartAction(); // Mantém a lógica de alternar o ícone
                              Provider.of<AppData>(context, listen: false).toggleFavorite(cityData['name']); // Adiciona ou remove dos favoritos
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 0, right: 15, bottom: 10, left: 15),
                      child: Text(
                        cityData['description'],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Helvetica Neue',
                        ),
                      ),
                    ),
                    Divider(thickness: 1),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'PRINCIPAIS PONTOS TURÍSTICOS',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Helvetica Neue',
                        ),
                      ),
                    ),
                    GridView.count(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 10 / 11,
                      children: List.generate(cityData['places'].length, (index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      cityData['places'][index]['img'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                child: Text(
                                  cityData['places'][index]['name'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Helvetica Neue',
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Ponto Turístico',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Helvetica Neue',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            height: 50,
            top: MediaQuery.of(context).padding.top,
            left: 10,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                backButtonAction(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
