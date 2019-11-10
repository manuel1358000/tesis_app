import 'package:flutter/material.dart';
import 'package:alerta_app/src/utils/utils.dart';
class RegistroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Text('REGISTRO USUARIOS'),
      ),
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _registroForm(context),
        ],
      )
    );
  }
  Widget _crearFondo(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white
      ),
    );
  }
  Widget _registroForm(BuildContext context){
    final size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 10.0,
            ), 
          ),
          Container(
            width: size.width*0.85,
            decoration:BoxDecoration(
              color: Colors.white,
           ),
            child: Column(
              children: <Widget>[
                _crearCUI(context),
                SizedBox(height: 15.0,),
                _crearNOMBRE(context),
                SizedBox(height: 15.0,),
                _crearPASSWORD(context),
                SizedBox(height: 15.0),
                _crearCONFIRMACIONPASSWORD(context),
                SizedBox(height: 15.0),
                _crearREGISTRO(context),
                SizedBox(height: 30.0,),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _crearCUI(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          fillColor: Colors.black26,
          labelText: 'CUI',
          hintText: 'Ej. 2000000000101',
          labelStyle: TextStyle(
            color: Color.fromRGBO(42,26,94,1.0)
          )
        ),
      ),
    );
  }
  Widget _crearNOMBRE(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          fillColor: Colors.black26,
          labelText: 'NOMBRE',
          hintText: 'Ej. Manuel Fuentes',
          labelStyle: TextStyle(
            color: Color.fromRGBO(42,26,94,1.0)
          )
        ),
      ),
    );
  }
  Widget _crearPASSWORD(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        style: TextStyle(
          color: Color.fromRGBO(42,26,94,1.0)
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          fillColor: Colors.black26,
          labelText: 'CONTRASEÑA',
          labelStyle: TextStyle(
            color: Color.fromRGBO(42,26,94,1.0)
          )
        ),
      ),
    );
  }
  Widget _crearCONFIRMACIONPASSWORD(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          fillColor: Colors.black26,
          labelText: 'CONFIRMACION CONTRASEÑA',
          labelStyle: TextStyle(
            color: Color.fromRGBO(42,26,94,1.0)
          )
        ),
      ),
    );
  }

Widget _crearREGISTRO(BuildContext context){
  final size=MediaQuery.of(context).size;
  return RaisedButton(
    color: Color.fromRGBO(42,26,94,1.0),
    child: Container(
      width:size.width*0.65,
      child: Center(
        child: Text('REGISTRAR',style: TextStyle(color:Colors.white)),
      )
    ),
    onPressed: (){
      Navigator.pushNamed(context,'registro');
    },
  );
}
}