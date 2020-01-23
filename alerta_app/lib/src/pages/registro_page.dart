import 'package:flutter/material.dart';
import 'dart:io';
import 'package:alerta_app/src/utils/data.dart';
import 'package:alerta_app/src/provider/usuario_provider.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:alerta_app/src/bloc/provider.dart';
import 'package:image_picker/image_picker.dart';
class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final usuarioProvider=new UsuarioProvider();

  File foto;

  @override
  Widget build(BuildContext context) {
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
    final bloc =Provider.ofRegistro(context);
    final size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.all(30.0),
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
              boxShadow: [new BoxShadow(
                color: Colors.black,
                blurRadius: 20.0,
              ),],
              borderRadius: new BorderRadius.all(Radius.circular(40.0))
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0,),
                _crearTexto(context),
                SizedBox(height:20.0,),
                _crearCUI(context,bloc),
                SizedBox(height: 15.0,),
                _crearNOMBRE(context,bloc),
                SizedBox(height: 15.0,),
                _crearPASSWORD(context,bloc),
                SizedBox(height: 15.0),
                _crearCONFIRMACIONPASSWORD(context,bloc),
                SizedBox(height: 20.0),
                _seleccionImagenes(context),
                SizedBox(height: 20.0),
                _crearREGISTRO(context,bloc),
                SizedBox(height: 30.0,),
                _crearLogin(context),
                SizedBox(height: 20.0,)
              ],
            ),
          )
        ],
      ),
    );
  }

  

  

  Widget _crearTexto(BuildContext context){
  return Center(
    child:Text('Registro Usuarios',style:TextStyle(fontWeight:FontWeight.bold,color: Color.fromRGBO(42,26,94,1.0),fontSize:20.0, )),
    );
}

  Widget _crearCUI(BuildContext context,RegistroBloc bloc){
    return StreamBuilder(
      stream:bloc.cuiStream,
      builder:(BuildContext context,AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Colors.black26,
              labelText: 'CUI/CARNÉ',
              hintText: 'Ej. 2000000000101',
              labelStyle: TextStyle(
                fontSize: 12.0,
                color: Color.fromRGBO(42,26,94,1.0)
              ),
              errorText: snapshot.error
            ),
            onChanged: (value)=>bloc.changeCui(int.parse(value)),
          ),
        );
      }
    );
  }

  Widget _crearNOMBRE(BuildContext context,RegistroBloc bloc){
    return StreamBuilder(
      stream:bloc.nombreStream,
      builder:(BuildContext context,AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Colors.black26,
              labelText: 'NOMBRE',
              hintText: 'Ej. Manuel Fuentes',
              labelStyle: TextStyle(
                fontSize: 12.0,
                color: Color.fromRGBO(42,26,94,1.0)
              ),
              errorText: snapshot.error
            ),
            onChanged: (value)=>bloc.changeNombre(value),
          ),
        );
      }
    );
  }

  Widget _crearPASSWORD(BuildContext context,RegistroBloc bloc){
    return StreamBuilder(
      stream:bloc.passwordStream,
      builder:(BuildContext context,AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Color.fromRGBO(42,26,94,1.0)
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Colors.black26,
              labelText: 'CONTRASEÑA',
              labelStyle: TextStyle(
                fontSize: 12.0,
                color: Color.fromRGBO(42,26,94,1.0)
              ),
              errorText: snapshot.error
            ),
            onChanged: (value)=>bloc.changePassword(value),
          ),
        );
      }
    );
  }

  Widget _crearCONFIRMACIONPASSWORD(BuildContext context,RegistroBloc bloc){
    return StreamBuilder(
      stream:bloc.confirmacionStream,
      builder:(BuildContext context,AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Colors.black26,
              labelText: 'CONFIRMACION CONTRASEÑA',
              labelStyle: TextStyle(
                fontSize: 12.0,
                color: Color.fromRGBO(42,26,94,1.0)
              ),
              errorText: snapshot.error
            ),
            onChanged: (value)=>bloc.changeConfirmacion(value),
          ),
        );
      }
    );
  }

Widget _crearREGISTRO(BuildContext context, RegistroBloc bloc){
  final size=MediaQuery.of(context).size;
  return StreamBuilder(
    stream: bloc.formValidator2,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return RaisedButton(
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        color: Color.fromRGBO(244,89,5,1.0),
        child: Container(
          width:size.width*0.65,
          child: Center(
            child: Text('REGISTRAR',style: TextStyle(color:Colors.white)),
          )
        ),
        onPressed: snapshot.hasData ? (){
          _registro(bloc,context);
        }:null,
      );
    },
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
_registro(RegistroBloc bloc,BuildContext context) async{
  if(bloc.password==bloc.confirmacion){
    if(foto==null){
      mostrarAlerta(context,'Ingrese una foto de perfil');
    }else{
      String urlimagen=await usuarioProvider.subirImagen(foto);
      if(urlimagen!=null){
        Map info=await usuarioProvider.nuevoUsuario(bloc.cui, bloc.password, bloc.nombre,1,1,urlimagen);
        if(info['codigo']==200){
          final Data data= new Data(contenido:'Usuario registrado de manera exitosa');
          Navigator.pushNamed(context, 'login',arguments:data);
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

 Widget _crearLogin(BuildContext context){
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('¿Ya tienes cuenta? ',style: TextStyle(fontWeight:FontWeight.bold,color: Color.fromRGBO(42,26,94,1.0),fontSize:12.0, ),),
            GestureDetector(
              child: Text('Iniciar Sesion',style:TextStyle(fontWeight:FontWeight.bold,color: Color.fromRGBO(244,89,5,1.0),fontSize:13.0, )),
              onTap: (){
                Navigator.pushNamed(context,'login');
              },
            )
          ],
        ) 
      );
  }
  _mostrarFoto(){
    if(foto!=null){
      return Image.file(
        foto,
        fit: BoxFit.cover,
        height: 100.0,
      );
    }
    return Image.asset('assets/no-image.png',height: 100,);
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