
import 'package:flutter/material.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:alerta_app/src/bloc/provider.dart';
import 'package:alerta_app/src/provider/usuario_provider.dart';
class LoginPage extends StatelessWidget {

  final usuarioProvider=new UsuarioProvider();
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
    final size=MediaQuery.of(context).size;
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
          child: Column(
            children: <Widget>[
              SizedBox(height: 15.0,),
              _crearLogo(context),
              SizedBox(height: 20.0,),
              _crearCUI(context,bloc),
              SizedBox(height: 15.0,),
              _crearPassword(context,bloc),
                SizedBox(height: 25.0,),
                _crearOlvido(context),
                SizedBox(height: 20.0),
                _crearIngreso(context,bloc),
                SizedBox(width: 50.0,),
                _crearInvitado(context),
                SizedBox(height: 30.0),
                _crearRegistro(context),
                SizedBox(height: 30.0,),
              ],
            ),
          )
        ],
      ),
    );
  }
Widget _crearLogo(BuildContext context){
  final size=MediaQuery.of(context).size;
  return Container(
    child: Image.asset('assets/logo.png',height: size.height*0.10),
  );
}
  Widget _crearCUI(BuildContext context,LoginBloc bloc){
    return StreamBuilder(
      stream: bloc.cuiStream,
      builder: (BuildContext context,AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              fillColor: Colors.black26,
              labelText: 'Cui',
              hintText: 'Ej. 20000000010101',
              labelStyle: TextStyle(
                color: Color.fromRGBO(42,26,94,1.0)
              ),
              errorText: snapshot.error
            ),
            onChanged: (value)=>bloc.changeCui(int.parse(value)),
          ),
        );  
      },
    );
  }
  Widget _crearPassword(BuildContext context,LoginBloc bloc){
    return StreamBuilder(
      stream:bloc.passwordStream,
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
              labelText: 'Contraseña',
              labelStyle: TextStyle(
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
  Widget _crearIngreso(BuildContext context,LoginBloc bloc){
  final size=MediaQuery.of(context).size;
  return StreamBuilder(
    stream: bloc.formValidator,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return RaisedButton(
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        color: Color.fromRGBO(42,26,94,1.0),
        child: Container(
          width:size.width*0.65,
          child: Center(
            child: Text('Iniciar Sesion',style: TextStyle(color:Colors.white)),
          )
        ),
        onPressed: snapshot.hasData ? (){
          _login(bloc,context);
        }:null,
      );  
    }
  );
}

_login(LoginBloc bloc, BuildContext context) async{
  Map info= await usuarioProvider.iniciarSesion(bloc.cui,bloc.password);
  if(info['codigo']==200){
    Navigator.pushReplacementNamed(context,'mapa');
  }else{
    mostrarAlerta(context,info['mensaje']);
  }

}
Widget _crearInvitado(BuildContext context){
  final size=MediaQuery.of(context).size;
  return RaisedButton(
    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
    color: Color.fromRGBO(244,89,5,1.0),
    child: Container(
      width:size.width*0.65,
      child: Center(
        child: Text('INVITADO',style: TextStyle(color:Colors.white)),
      )
    ),
    onPressed: (){
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context,'mapa');
    },
  );
}

 Widget _crearRegistro(BuildContext context){
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('¿Aun no tienes cuenta? ',style: TextStyle(fontWeight:FontWeight.bold,color: Color.fromRGBO(42,26,94,1.0),fontSize:12.0, ),),
            GestureDetector(
              child: Text('Registrate',style:TextStyle(fontWeight:FontWeight.bold,color: Color.fromRGBO(244,89,5,1.0),fontSize:13.0, )),
              onTap: (){
                Navigator.pushNamed(context,'registro');
              },
            )
          ],
        ) 
      );
  }
Widget _crearOlvido(BuildContext context){
  return Center(
      child: Container(
        child: GestureDetector(
          child: Text('¿Olvidaste tu contraseña?',style:TextStyle(fontWeight:FontWeight.bold,color: Color.fromRGBO(42,26,94,1.0),fontSize:12.0, )),
          onTap: (){
            Navigator.pushNamed(context,'recuperar');
          },
        )
      ),
    );
}
}