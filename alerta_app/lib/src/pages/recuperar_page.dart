import 'package:flutter/material.dart';
class RecuperarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Recuperar Contraseña'),
      ),
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _recuperarForm(context)
        ],
      )
    );
  }
Widget _crearFondo(BuildContext context){
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white
      ),
    );
  }
Widget _recuperarForm(BuildContext context){
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
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height*0.25),
                  _crearTexto(context),
                  _crearCUI(context),
                  SizedBox(height: 15.0,),
                  _crearRecuperar(context),
                  SizedBox(height: 30.0,),
                ],
              ),
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
          hintText: '2000000000101',
          labelStyle: TextStyle(
            color: Color.fromRGBO(42,26,94,1.0)
          )
        ),
      ),
    );
  }
   Widget _crearTexto(BuildContext context){
    return Center(
      child: Container(
        child: GestureDetector(
          child: Text('Ingresa CUI',style:TextStyle(fontWeight:FontWeight.bold,color: Color.fromRGBO(42,26,94,1.0),fontSize:20.0, )),
          onTap: (){
            Navigator.pushNamed(context,'recuperar');
          },
        )
      ),
    );
  }
  Widget _crearRecuperar(BuildContext context){
    final size=MediaQuery.of(context).size;
    return RaisedButton(
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      color: Color.fromRGBO(42,26,94,1.0),
      child: Container(
        width:size.width*0.65,
        child: Center(
          child: Text('RECUPERAR CONTRASEÑA',style: TextStyle(color:Colors.white)),
        )
      ),
      onPressed: (){
        Navigator.pushNamed(context,'registro');
      },
    );
  }
}