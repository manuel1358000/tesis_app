import 'package:flutter/material.dart';
class TerminosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _textForm(context)
        ],
      )
    );
  }
  Widget _crearFondo(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
    );
  }
  Widget _textForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child:Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height*0.03),
            FlatButton(
              child: Text('PANTALLA TERMINOS Y CONDICIONES'),
              onPressed: (){
                print('Terminos y Condiciones');
              },
            ),
            SizedBox(height: size.height*0.05),
          ],
        ),
      )
    );
  }
}