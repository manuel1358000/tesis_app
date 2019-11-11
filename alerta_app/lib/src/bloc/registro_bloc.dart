import 'dart:async';

import 'package:rxdart/rxdart.dart';

class RegistroBloc{

  final _cuiController          =BehaviorSubject<int>();
  final _nombreController       =BehaviorSubject<String>();
  final _passwordController     =BehaviorSubject<String>();
  final _confirmacionController =BehaviorSubject<String>();

  //recuperar los datos del Stream
  Stream<int>   get cuiStream          => _cuiController.stream;
  Stream<String>get nombreStream       => _nombreController.stream;
  Stream<String>get passwordStream     => _passwordController.stream;
  Stream<String>get confirmacionStream => _confirmacionController.stream;
  //insertar valores al stream
  Function(int)    get changeCui            => _cuiController.sink.add;
  Function(String) get changeNombre         => _nombreController.sink.add;
  Function(String) get changePassword       => _passwordController.sink.add;
  Function(String) get changeConfirmacion   => _confirmacionController.sink.add;
  
    //obtener el ultimo valor ingresado a los textinput
  int get cui=>_cuiController.value;
  String get nombre=>_nombreController.value;
  String get password=>_passwordController.value;
  String get confirmacion=>_confirmacionController.value;
  
  dispose(){
    _cuiController?.close();
    _nombreController?.close();
    _passwordController?.close();
    _confirmacionController?.close();
  }
}