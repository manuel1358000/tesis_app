import 'package:flutter/material.dart';
import 'package:alerta_app/src/widgets/menu_widget.dart';
class PublicacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PUBLICACIONES'),
      ),
      body: Container(
        child: Center(
          child: Text('PUBLICACIONES'),
        ),
      ),
      drawer: MenuWidget(),
    );
  }
}