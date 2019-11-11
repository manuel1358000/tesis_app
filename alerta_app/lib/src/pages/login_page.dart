
import 'package:flutter/material.dart';
import 'package:alerta_app/src/utils/utils.dart';
import 'package:alerta_app/src/bloc/provider.dart';
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Text('Alerta USAC'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed:()=>Navigator.pushNamed(context,'info') 
          ),
        ],
      ),
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
        color: Colors.white
      ),
    );
  }
  Widget _loginForm(BuildContext context){
    final bloc =Provider.ofLogin(context);
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
                _crearLogo(context),
                _crearCUI(context,bloc),
                SizedBox(height: 15.0,),
                _crearPassword(context,bloc),
                SizedBox(height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _crearIngreso(context,bloc),
                    SizedBox(width: 10.0,),
                    _crearInvitado(context)
                  ],
                ),
                SizedBox(height: 15.0),
                _crearOlvido(context,'¿Haz olvidado tu contraseña?'),
                SizedBox(height: 20.0),
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
    child: Image.asset('assets/mapa3.jpg',height: size.height*0.30,),
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
              fillColor: Colors.black26,
              labelText: 'CUI',
              hintText: 'Ej. 20000000010101',
              labelStyle: TextStyle(
                color: Color.fromRGBO(42,26,94,1.0)
              )
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
  Widget _crearIngreso(BuildContext context,LoginBloc bloc){
    final size=MediaQuery.of(context).size;
  return RaisedButton(
    color: Color.fromRGBO(42,26,94,1.0),
    child: Container(
      width:size.width*0.35,
      child: Center(
        child: Text('INICIAR SESION',style: TextStyle(color:Colors.white)),
      )
    ),
    onPressed: (){
      _login(bloc,context);
    },
  );
}

_login(LoginBloc bloc, BuildContext context){
  mostrarAlerta(context,'CUI: ${bloc.cui} PASSWORD: ${bloc.password}');
  Navigator.pushReplacementNamed(context,'mapa');
}
Widget _crearInvitado(BuildContext context){
  final size=MediaQuery.of(context).size;
  return RaisedButton(
    color: Color.fromRGBO(244,89,5,1.0),
    child: Container(
      width:size.width*0.25,
      child: Center(
        child: Text('INVITADO',style: TextStyle(color:Colors.white)),
      )
    ),
    onPressed: (){
      Navigator.pushReplacementNamed(context,'mapa');
    },
  );
}

 Widget _crearOlvido(BuildContext context,String texto){
    return Center(
      child: Container(
        child: GestureDetector(
          child: Text(texto,style:TextStyle(fontWeight:FontWeight.bold,color: Color.fromRGBO(42,26,94,1.0),fontSize:12.0, )),
          onTap: (){
            Navigator.pushNamed(context,'recuperar');
          },
        )
      ),
    );
  }
Widget _crearRegistro(BuildContext context){
  final size=MediaQuery.of(context).size;
  return RaisedButton(
    color: Color.fromRGBO(42,26,94,1.0),
    child: Container(
      width:size.width*0.65,
      child: Center(
        child: Text('REGISTRO',style: TextStyle(color:Colors.white)),
      )
    ),
    onPressed: (){
      Navigator.pushNamed(context,'registro');
    },
  );
}
}