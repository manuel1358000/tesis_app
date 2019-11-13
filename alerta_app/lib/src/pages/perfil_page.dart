import 'package:flutter/material.dart';
import 'package:alerta_app/src/widgets/menu_widget.dart';
class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('PERFIL'),
      ),
      body: Container(
        child: Center(
          child: Text('PERFIL'),
        ),
      ),
      drawer: MenuWidget(),
    );
  }
}