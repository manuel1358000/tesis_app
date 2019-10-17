import 'package:flutter/material.dart';
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context)
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
                SizedBox( height: size.height*0.03),
                _crearBoton(Color.fromRGBO(42,26,94,1.0),'Escanear Carné',context,'mapa'),
                SizedBox(height: size.height*0.05),
                _crearBoton(Color.fromRGBO(255,20,5,1.0),'Invitado',context,'mapa'),
                SizedBox(height: size.height*0.03),
                 FlatButton(
                  child: Text('Terminos y Condiciones'),
                  onPressed:()=>Navigator.pushNamed(context,'terminos') 
                ),
                SizedBox(height: size.height*0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _crearBoton(Color color,String texto,BuildContext context,String ruta) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width*0.75, // specific value
      child: RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text(texto),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0)
          ),
          elevation: 5.0,
          color: color,
          textColor: Colors.white,
          onPressed: ()=>Navigator.pushReplacementNamed(context,ruta),
        )
    );
  }

  Widget _crearLogo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height*0.12,right: size.height*0.10,left: size.height*0.10),
      child: Image(
        image: AssetImage('assets/mapa3.jpg'),
      ),
    );

  }

}