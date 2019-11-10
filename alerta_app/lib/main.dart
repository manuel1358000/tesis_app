import 'package:flutter/material.dart';
import 'package:alerta_app/src/pages/registro_page.dart';
import 'package:alerta_app/src/pages/info_page.dart';
import 'package:alerta_app/src/pages/login_page.dart';
import 'package:alerta_app/src/pages/recuperar_page.dart';
import 'package:alerta_app/src/pages/mapa_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alerta App',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) =>LoginPage(),
        'recuperar': (BuildContext context) =>RecuperarPage(),
        'mapa': (BuildContext context) =>MapaPage(),
        'info': (BuildContext context) =>InfoPage(),
        'registro': (BuildContext context) =>RegistroPage(),
      },
      theme:ThemeData(
        primaryColor: Color.fromRGBO(42,26,94,1.0),
      ),
    );
  }
}