import 'dart:async';

import 'package:rxdart/rxdart.dart';

class LoginBloc{

  final _cuiController      = BehaviorSubject<int>();
  final _passwordController = BehaviorSubject<String>();

  //recuperar los datos del Stream
  Stream<int>   get cuiStream      => _cuiController.stream;
  Stream<String>get passwordStream => _passwordController.stream;

  //insertar valores al stream
  Function(int)    get changeCui      => _cuiController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //obtener el ultimo valor ingresado a los textinput
  int get cui=>_cuiController.value;
  String get password=>_passwordController.value;

  set setCui(int valor)=>_cuiController.value=valor;
  set setPassword(String valor)=>_passwordController.value=valor;


  dispose(){
    _cuiController?.close();
    _passwordController?.close();
  }
}