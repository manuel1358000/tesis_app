import 'package:flutter/material.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:alerta_app/src/widgets/menu_widget.dart';
import 'package:url_launcher/url_launcher.dart';
class EmergenciaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Numeros emergencia'),
      ),
      body: Stack(
        children:<Widget>[
          _generarFondo(),
          _generarEstructura(context),
        ] 
      ),
      drawer: MenuWidget(),
    );
  }
  Widget _generarFondo(){
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color.fromRGBO(42,26,94,1.0),
    );
  }
  Widget _generarEstructura(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30.0),
            _generarNumero(context,'Policia Nacional Civil','110','assets/policia.png'),
            SizedBox(height: 30.0),
            _generarNumero(context,'Bomberos Voluntarios','24715012','assets/bomberos.jpg'),
            SizedBox(height: 30.0),
            _generarNumero(context,'Bomberos Municipales','24755262','assets/municipales.jpg'),
            SizedBox(height: 30.0),
            _generarNumero(context,'Seguridad CUM','1585','assets/usac.jpg'),
            SizedBox(height: 30.0),
            _generarNumero(context,'Denuncias USAC','1514','assets/usac.jpg'),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
  Widget _generarNumero(BuildContext context,String titulo,String numero,String imagen){
    final _size=MediaQuery.of(context).size;
    return Container(
      width: _size.width*0.80,
      height: _size.height*0.15,
      decoration:BoxDecoration(
        boxShadow: [new BoxShadow(
          color: Colors.black,
          blurRadius: 10.0,
        ),],
        color: Colors.white,
        borderRadius: new BorderRadius.all(Radius.circular(60.0))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage(imagen),
            backgroundColor: Colors.white,
            radius: 50,
          ),
          SizedBox(width: 50.0),
          GestureDetector(
            onTap: (){
              _launchURL('tel:'+numero);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(titulo,style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 14)),
                Text(numero,style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 16)),
                Icon(Icons.call,color: Color.fromRGBO(42,26,94,1.0)),
                SizedBox(height: 5),
                Text('Presiona para llamar',style: TextStyle(color: Color.fromRGBO(42,26,94,1.0),fontSize: 8)),
              ],
            ),
          )
        ],
      ),
    );
  }
  _launchURL(String numero) async {
    const url='tel:+155501099';
  if (await canLaunch(numero)) {
    await launch(numero);
  } else {
    throw 'Could not launch $numero';
  }
}
}