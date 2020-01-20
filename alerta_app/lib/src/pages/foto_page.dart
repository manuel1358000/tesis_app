import 'package:flutter/material.dart';
import 'dart:io';
import 'package:alerta_app/src/bloc/provider.dart';
import 'package:image_picker/image_picker.dart';
class FotoPage extends StatefulWidget {
  @override
  _FotoPageState createState() => _FotoPageState();
}

class _FotoPageState extends State<FotoPage> {
  File foto;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      )
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

  Widget _loginForm(BuildContext context){
    final bloc =Provider.ofLogin(context);
    final size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: size.height*0.15,
            ), 
          ),
          Container(
            width: size.width*0.85,
            decoration:BoxDecoration(
              boxShadow: [new BoxShadow(
                color: Colors.black,
                blurRadius: 20.0,
              ),],
              color: Colors.white,
              borderRadius: new BorderRadius.all(Radius.circular(40.0))
            ),
            child: _seleccionImagenes(context),
          )
        ],
      ),
    );
  }
  Widget _seleccionImagenes(BuildContext context){
    return Column(
      children: <Widget>[
        _mostrarFoto(),
        IconButton(
          icon: Icon(Icons.photo_size_select_actual),
          onPressed: _seleccionarFoto,
        ),
        IconButton(
          icon:Icon(Icons.camera_alt),
          onPressed: _seleccionarImagen,
        ),
      ],
    );
  }

  _mostrarFoto(){
    if(foto!=null){
      return Image.file(
        foto,
        fit: BoxFit.cover,
        height: 300.0,
      );
    }
    return Image.asset('assets/no-image.png');
  }

  _seleccionarFoto()async{
    foto = await ImagePicker.pickImage(
      source: ImageSource.gallery
    );
    if(foto!=null){
      //limpieza
    }
    setState(() {});
  }
  _seleccionarImagen(){

  }

}