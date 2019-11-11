import 'package:flutter/material.dart';
import 'package:alerta_app/src/bloc/login_bloc.dart';
import 'package:alerta_app/src/bloc/registro_bloc.dart';
export 'package:alerta_app/src/bloc/login_bloc.dart';
export 'package:alerta_app/src/bloc/registro_bloc.dart';
class Provider extends InheritedWidget{

  final loginBloc= LoginBloc();
  final registroBloc= RegistroBloc();
  Provider({Key key, Widget child})
    : super(key:key,child:child);



  @override
  bool updateShouldNotify(InheritedWidget oldWidget)=>true;

  static LoginBloc ofLogin(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider)as Provider).loginBloc;
  }
  static RegistroBloc ofRegistro(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider)as Provider).registroBloc;
  }
}