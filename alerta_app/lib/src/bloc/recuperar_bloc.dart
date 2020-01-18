import 'dart:async';
import 'package:alerta_app/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class RecuperarBloc with Validators{

  final _cuiController      = BehaviorSubject<int>();
  //recuperar los datos del Stream
  Stream<int>   get cuiStream      => _cuiController.stream.transform(validarCUI);
  
  
  Stream<bool> get formValidator=>cuiStream.map((email)=>true);

  //insertar valores al stream
  Function(int)    get changeCui      => _cuiController.sink.add;
  
  //obtener el ultimo valor ingresado a los textinput
  int get cui=>_cuiController.value;
  
  set setCui(int valor)=>_cuiController.value=valor;

  dispose(){
    _cuiController?.close();
  }
}