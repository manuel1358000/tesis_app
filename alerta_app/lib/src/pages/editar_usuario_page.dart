import 'dart:io';
import 'package:flutter/material.dart';
import 'package:alerta_app/src/models/usuario_model.dart';
import 'package:alerta_app/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:alerta_app/src/utils/data.dart';
import 'package:alerta_app/src/provider/usuario_provider.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
class EditarUsuarioPage extends StatefulWidget {
  @override
  _EditarUsuarioPageState createState() => _EditarUsuarioPageState();
}

class _EditarUsuarioPageState extends State<EditarUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  final usuarioProvider=new UsuarioProvider();
  final _prefs = new PreferenciasUsuario();
  final _url='192.168.0.17';
  //final _url='34.67.241.151';
  UsuarioModel usuariomodel=new UsuarioModel();
  File foto;
  @override
  Widget build(BuildContext context) {   
    UsuarioModel usuarioData=ModalRoute.of(context).settings.arguments;
    if(usuarioData!=null&&usuariomodel.estado==true){
      usuariomodel=usuarioData;
      usuariomodel.estado=false;
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _registroForm(context),
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

  Widget _registroForm(BuildContext context){
    final size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: size.height*0.10,
            ), 
          ),
          Container(
            width: size.width*0.85,
            decoration:BoxDecoration(
              color: Colors.white,
              boxShadow: [new BoxShadow(
                color: Colors.black,
                blurRadius: 20.0,
              ),],
              borderRadius: new BorderRadius.all(Radius.circular(40.0))
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0,),
                  _crearTexto(context),
                  SizedBox(height:20.0,),
                  _crearCUI(context),
                  SizedBox(height: 15.0,),
                  _crearNOMBRE(context),
                  SizedBox(height: 15.0,),
                  _crearPASSWORD(context),
                  SizedBox(height: 15.0),
                  _crearCONFIRMACIONPASSWORD(context),
                  SizedBox(height: 20.0),
                   SizedBox(height: 20.0),
                  _seleccionImagenes(context),
                  _crearEDITAR(context),
                  SizedBox(height: 30.0,),
                ],
              ),
            ),
          )
        ], 
      ),
    );
  }

  Widget _crearTexto(BuildContext context){
    return Center(
      child:Text('Actualizar datos',style:TextStyle(fontWeight:FontWeight.bold,color: Color.fromRGBO(42,26,94,1.0),fontSize:20.0, )),
    );
  }

  Widget _crearCUI(BuildContext context){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            enabled: false,
            initialValue: usuariomodel.cui.toString(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Colors.black26,
              labelText: 'Cui',
              hintText: 'Ej. 2000000000101',
              labelStyle: TextStyle(
                fontSize: 12.0,
                color: Color.fromRGBO(42,26,94,1.0)
              ),
            ),
            onChanged: (value)=>usuariomodel.cui=int.parse(value),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        );
  }

  Widget _crearNOMBRE(BuildContext context){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            initialValue:usuariomodel.nombre,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Colors.black26,
              labelText: 'Nombre',
              hintText: 'Ej. Manuel Fuentes',
              labelStyle: TextStyle(
                fontSize: 12.0,
                color: Color.fromRGBO(42,26,94,1.0)
              ),
            ),
            onChanged: (value)=>usuariomodel.nombre=value,
            validator: (value) {
              if (value.isEmpty) {
                return 'Ingrese un nombre valido';
              }
              return null;
            },
          ),
        );
  }

  Widget _crearPASSWORD(BuildContext context){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            initialValue: usuariomodel.password,
            obscureText: true,
            style: TextStyle(
              color: Color.fromRGBO(42,26,94,1.0)
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Colors.black26,
              labelText: 'Contraseña',
              labelStyle: TextStyle(
                fontSize: 12.0,
                color: Color.fromRGBO(42,26,94,1.0)
              ),
            ),
            onChanged: (value)=>usuariomodel.password=value,
            validator: (value) {
              if (value.isEmpty) {
                return 'Ingrese una contraseña';
              }
              return null;
            },
          ),
        );
  }

  Widget _crearCONFIRMACIONPASSWORD(BuildContext context){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            initialValue: usuariomodel.password,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Colors.black26,
              labelText: 'Confirmacion contraseña',
              labelStyle: TextStyle(
                fontSize: 12.0,
                color: Color.fromRGBO(42,26,94,1.0)
              ),
            ),
            onChanged: (value)=>usuariomodel.confirmacion=value,
            validator: (value) {
              if (value.isEmpty) {
                return 'Ingrese una contraseña';
              }
              return null;
            },
          ),
        );

  }
  Widget _seleccionImagenes(BuildContext context){
    return Column(
      children: <Widget>[
        _mostrarFoto(),
        SizedBox(height: 10.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _seleccionarFoto,
            ),
            IconButton(
              icon:Icon(Icons.camera_alt),
              onPressed: _seleccionarImagen,
            ),
          ],
        ),
        Text('Foto Perfil'),
      ],
    );
  }
Widget _crearEDITAR(BuildContext context){
  final size=MediaQuery.of(context).size;
      return RaisedButton(
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        color: Color.fromRGBO(244,89,5,1.0),
        child: Container(
          width:size.width*0.65,
          child: Center(
            child: Text('Actualizar datos',style: TextStyle(color:Colors.white)),
          )
        ),
        onPressed: usuariomodel!=null ? (){
          if(_formKey.currentState.validate()){
            _editar(usuariomodel,context);
          }
        }:null,
      );
}

_editar(UsuarioModel usuario,BuildContext context) async{
  if(usuario.password==usuario.confirmacion){
    if(foto==null){
       Map info=await usuarioProvider.editarUsuario(usuario.cui,usuario.password,usuario.nombre,usuario.imagen);
      if(info['codigo']==200){
        _prefs.nombre=usuario.nombre;
        _prefs.password=usuario.password;
        final Data data= new Data(contenido:'Los datos se actualizaron de manera correcta');
        Navigator.pushReplacementNamed(context,'perfil',arguments:data);
      }else{
        mostrarAlerta(context,info['mensaje']);
      }
    }else{
      String urlimagen=await usuarioProvider.subirImagen(foto);
      if(urlimagen!=null){
        Map info=await usuarioProvider.editarUsuario(usuario.cui,usuario.password,usuario.nombre,urlimagen);
        if(info['codigo']==200){
          _prefs.nombre=usuario.nombre;
          _prefs.password=usuario.password;
          final Data data= new Data(contenido:'Los datos se actualizaron de manera correcta');
          Navigator.pushReplacementNamed(context,'perfil',arguments:data);
        }else{
          mostrarAlerta(context,info['mensaje']);
        }
      }else{
        mostrarAlerta(context,'Ocurrio un error intente nuevamente');
      }
    }
       
  }else{
    mostrarAlerta(context,'Las contraseñas no coinciden, por favor intente nuevamente.');
  }
}
 Widget _mostrarFoto(){
    if(foto!=null){
      return Image.file(
        foto,
        fit: BoxFit.cover,
        height: 100.0,
      );
    }
    return FadeInImage.assetNetwork(
      placeholder: 'assets/jar-loading.gif',
      image: 'http://'+_url+':3000/'+usuariomodel.imagen,
    );
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

  _seleccionarImagen()async{
    foto = await ImagePicker.pickImage(
      source: ImageSource.camera
    );
    if(foto!=null){
      //limpieza
    }
    setState(() {});
  }
}