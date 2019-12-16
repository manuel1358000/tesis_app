import 'package:flutter/material.dart';
import 'package:alerta_app/src/provider/usuario_provider.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:alerta_app/src/bloc/provider.dart';
class RegistroPage extends StatelessWidget {
  final usuarioProvider=new UsuarioProvider();
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
    final size=MediaQuery.of(context).size;
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
              labelText: 'CUI',
              hintText: 'Ej. 2000000000101',
              labelStyle: TextStyle(
                fontSize: 12.0,
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Colors.black26,
              labelText: 'CONTRASEÑA',
              labelStyle: TextStyle(
                fontSize: 12.0,
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Colors.black26,
              labelText: 'CONFIRMACION CONTRASEÑA',
              labelStyle: TextStyle(
                fontSize: 12.0,
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
    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
    color: Color.fromRGBO(244,89,5,1.0),
    child: Container(
      width:size.width*0.65,
      child: Center(
        child: Text('REGISTRAR',style: TextStyle(color:Colors.white)),
      )
    ),
    onPressed: (){
      _registro(bloc,context);
    },
  );
}

_registro(RegistroBloc bloc,BuildContext context) async{
  Map info=await usuarioProvider.nuevoUsuario(bloc.cui, bloc.password, bloc.nombre,1,1);
  if(info['codigo']==200){
    mostrarAlerta(context,'Usuario creado exitosamente');
    Navigator.pushNamedAndRemoveUntil(context, 'login', (_) => true);
  }else{
    mostrarAlerta(context,info['mensaje']);
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
}