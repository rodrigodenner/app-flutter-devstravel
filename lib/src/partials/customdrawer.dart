import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget implements PreferredSizeWidget {
  final BuildContext pageContext;


  const CustomDrawer({
    Key? key,
    required this.pageContext,

  }) : super(key: key);


  @override
  _CustomDrawerState createState() => _CustomDrawerState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'DevsTravel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Helvetica Neue',
                  ),
                ),
                Text(
                  'versão 1.0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Helvetica Neue',
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
              leading: Icon(Icons.home, color: Colors.black,), title: Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(widget.pageContext, '/home');
              }),
          ListTile(
              leading: Icon(Icons.public,color: Colors.black),
              title: Text('Continente'),
              onTap: () {
                Navigator.pushReplacementNamed(widget.pageContext, '/continent');
              }),
          ListTile(
              leading: Icon(Icons.search, color: Colors.black),
              title: Text('Buscar Cidade'),
              onTap: () {
                Navigator.pushReplacementNamed(widget.pageContext, '/search');
              }),
          ListTile(
              leading: Icon(Icons.favorite, color: Colors.black),
              title: Text('Cidades Salvas'),
              onTap: () {
                Navigator.pushReplacementNamed(widget.pageContext, '/saved');
              }),
        ],
      ),
    );
  }
}
