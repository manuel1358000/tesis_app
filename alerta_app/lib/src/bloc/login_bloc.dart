import 'dart:async';
import 'package:alerta_app/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{

  final _cuiController      = BehaviorSubject<int>();
  final _passwordController = BehaviorSubject<String>();

  //recuperar los datos del Stream
  Stream<int>   get cuiStream      => _cuiController.stream.transform(validarCUI);
  Stream<String>get passwordStream => _passwordController.stream.transform(validarCONTRA);

  Stream<bool> get formValidator=>
          Observable.combineLatest2(cuiStream, passwordStream,(e,p)=>true);


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