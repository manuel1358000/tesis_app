import 'package:flutter/material.dart';
import 'package:alerta_app/src/models/publicacion_model.dart';
class EditarEventoPage extends StatefulWidget {
  @override
  _EditarEventoPageState createState() => _EditarEventoPageState();
  }

class _EditarEventoPageState extends State<EditarEventoPage> {
  PublicacionModel publicacionmodel=new PublicacionModel();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {   
    PublicacionModel publicacionData=ModalRoute.of(context).settings.arguments;   
    if(publicacionData!=null&&publicacionmodel.estado==true){
      publicacionmodel=publicacionData;
      publicacionmodel.estado=false;
    }
    return Scaffold(
       appBar:PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height 
        child: AppBar(
          backgroundColor: Color.fromRGBO(244,89,5,1.0),
          title: Text('AlertaUSAC'),
          centerTitle: true,
          elevation: 5.0,
        ),
      ),
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _crearFormulario()

        ],
      )
    );
  }
  Widget _crearFormulario(){
    return Container(
      child: Text(publicacionmodel.nombre),
    );
  }
 Widget _crearFondo(BuildContext context){
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(42,26,94,1.0)
      ),
    );
  }
}