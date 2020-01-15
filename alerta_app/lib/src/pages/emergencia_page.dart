import 'package:flutter/material.dart';
import 'package:alerta_app/src/widgets/menu_widget.dart';
class EmergenciaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Numeros emergencia'),
      ),
      body: Container(
        child: Center(
          child: _generarNumeros(),
        ),
      ),
      drawer: MenuWidget(),
    );
  }
  Widget _generarNumeros(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text('Hola'),
          Divider(),
          Text('Hola'),
          Divider(),
          Text('Hola'),
          Divider(),
          Text('Hola'),
          Divider(),
        ],
      ),
    );
  }
}