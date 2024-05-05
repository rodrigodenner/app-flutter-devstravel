import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';

class PreloadPage extends StatefulWidget {
  @override
  _PreloadPageState createState() => _PreloadPageState();
}

class _PreloadPageState extends State<PreloadPage> {
  bool loading = true;

  void requestInfo() async {
    await Future.delayed(const Duration(seconds: 1));

    bool req = await Provider.of<AppData>(context, listen: false).requestData();

    if (!req) {
      setState(() {
        loading = false;
      });
    }

    Navigator.pushReplacementNamed(context, '/home');

  }

  @override
  void initState() {
    super.initState();
    requestInfo();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/assets/logo.png',
              width: 200,
            ),
            loading
                ? Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  )
                : Container(),
            !loading
                ? Container(
                    margin: const EdgeInsets.all(30),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          loading =
                              true; // Define loading como true para exibir o indicador de carregamento
                        });
                        requestInfo(); // Chama novamente o método requestInfo() para fazer uma nova solicitação
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Cor de fundo
                      ),
                      child: const Text(
                        'Tente Novamente',
                        style: TextStyle(color: Colors.white), // Cor do texto
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
