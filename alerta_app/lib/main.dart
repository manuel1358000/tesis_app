import 'package:flutter/material.dart';
import 'package:alerta_app/src/pages/login.dart';
import 'package:alerta_app/src/pages/terminos.dart';
import 'package:alerta_app/src/pages/mapa.dart';
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
        'terminos': (BuildContext context) =>TerminosPage(),
        'mapa': (BuildContext context) =>MapaPage(),
      },
    );
  }
}