import 'package:flutter/material.dart';
import 'package:alerta_app/src/provider/usuario_provider.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:alerta_app/src/bloc/provider.dart';
class RegistroPage extends StatelessWidget {

  final usuarioProvider=new UsuarioProvider();


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
    final bloc =Provider.ofRegistro(context);
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
                SizedBox(height: 30.0,),
                _crearCUI(context,bloc),
                SizedBox(height: 15.0,),
                _crearNOMBRE(context,bloc),
                SizedBox(height: 15.0,),
                _crearPASSWORD(context,bloc),
                SizedBox(height: 15.0),
                _crearCONFIRMACIONPASSWORD(context,bloc),
                SizedBox(height: 40.0),
                _crearREGISTRO(context,bloc),
                SizedBox(height: 30.0,),
              ],
            ),
          )
        ],
      ),
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
              fillColor: Colors.black26,
              labelText: 'CUI',
              hintText: 'Ej. 2000000000101',
              labelStyle: TextStyle(
                color: Color.fromRGBO(42,26,94,1.0)
              )
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
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              fillColor: Colors.black26,
              labelText: 'NOMBRE',
              hintText: 'Ej. Manuel Fuentes',
              labelStyle: TextStyle(
                color: Color.fromRGBO(42,26,94,1.0)
              )
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
              fillColor: Colors.black26,
              labelText: 'CONTRASEÑA',
              labelStyle: TextStyle(
                color: Color.fromRGBO(42,26,94,1.0)
              )
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
              fillColor: Colors.black26,
              labelText: 'CONFIRMACION CONTRASEÑA',
              labelStyle: TextStyle(
                color: Color.fromRGBO(42,26,94,1.0)
              )
            ),
            onChanged: (value)=>bloc.changeConfirmacion(value),
          ),
        );
      }
    );
  }

Widget _crearREGISTRO(BuildContext context, RegistroBloc bloc){
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
      _registro(bloc,context);
      //Navigator.pushNamed(context,'registro');
    },
  );
}
_registro(RegistroBloc bloc,BuildContext context){
    mostrarAlerta(context, 'CUI: ${bloc.cui} NOMBRE: ${bloc.nombre} PASSWORD: ${bloc.password} CONFIRMACION: ${bloc.confirmacion}');
}
}