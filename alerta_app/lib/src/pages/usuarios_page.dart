import 'package:flutter/material.dart';
import 'package:alerta_app/src/widgets/menu_widget.dart';
class UsuariosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('USUARIOS'),
      ),
      body: Container(
        child: Center(
          child: Text('USUARIOS'),
        ),
      ),
      drawer: MenuWidget(),
    );
  }
}