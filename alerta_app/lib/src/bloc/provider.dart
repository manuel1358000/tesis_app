import 'package:alerta_app/src/bloc/recuperar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:alerta_app/src/bloc/login_bloc.dart';
import 'package:alerta_app/src/bloc/registro_bloc.dart';
import 'package:alerta_app/src/bloc/publicacion_bloc.dart';
export 'package:alerta_app/src/bloc/login_bloc.dart';
export 'package:alerta_app/src/bloc/registro_bloc.dart';
class Provider extends InheritedWidget{

  static Provider _instancia;

  factory Provider({Key key, Widget child}){
    if(_instancia==null){
      _instancia=new Provider._internal(key:key,child: child,);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child})
    : super(key:key,child:child);

  final loginBloc= LoginBloc();
  final registroBloc= RegistroBloc();
  final publicacionBloc= PublicacionBloc();
  final recuperarBloc= RecuperarBloc();


  


  @override
  bool updateShouldNotify(InheritedWidget oldWidget)=>true;

  static LoginBloc ofLogin(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }
  static RegistroBloc ofRegistro(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>().registroBloc;
  }
  static PublicacionBloc ofPublicacion(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>().publicacionBloc;
  }
  static RecuperarBloc ofRecuperar(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>().recuperarBloc;
  }
}