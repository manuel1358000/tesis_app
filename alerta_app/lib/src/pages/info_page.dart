import 'package:flutter/material.dart';
class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Informacion'),
      ),
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context)
        ],
      )
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                _crearLogo(context),
                SizedBox( height: size.height*0.01),
                _crearTitulo(),
                _crearDescripcion(),
                _crearAutor(),
              ],
            ),
          ),
        ],
      ),
    );
  }
   Widget _crearLogo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height*0.01,right: size.height*0.15,left: size.height*0.15),
      child: Image(
        image: AssetImage('assets/mapa3.jpg'),
      ),
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

  
  Widget _crearTitulo(){
    return SafeArea(
      child: Container(
        child: Text(
          'ALERTAUSAC',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  Widget _crearDescripcion(){
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0),
        child: Text(
          'Se plantea el desarrollo de una aplicación para teléfonos móviles con sistema operativo Android que permita la centralización'+
          'de alertas y eventos que sucedan dentro del centro universitario metropolitano (CUM), esta aplicación permitirá el registro por'+
          ' medio del carnet que genera la USAC, además de esto permitiría ingresar al contenido de la aplicación como usuario invitado.\n'+
          'Para poder ingresar a la aplicación es necesario ingresar el número de carne o Código Único de Identificación (CUI) y una contraseña,'+
          ' con este proceso se podrá determinar si la persona que va a ingresar a la aplicación, es un estudiante, personal de las unidades '+
          'académicas o si es el usuario administrador. \nLas alertas y eventos que sucedan dentro de las instalaciones del CUM se registraran'+
          ' por medio de la aplicación la cual obtendrá la ubicación exacta del dispositivo por medio del GPS que tiene integrado, por lo que'+
          ' se contara con la posición exacta de las alertas y eventos. Las alertas y eventos tienen diferentes tipos los cuales vamos a detallar'+
          ' en la siguiente sección.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
  Widget _crearAutor(){
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0),
        child: Text(
          'Desarrollado por: \nManuel Antonio Fuentes Fuentes \nFacultad de Ingenieria \nEscuela Ciencias y Sistemas',
          textAlign: TextAlign.justify,
          style: TextStyle(fontWeight: FontWeight.bold)
        ),
      ),
    );
  }
}