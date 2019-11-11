import 'dart:async';

class RegistroBloc{

  final _cuiController          =StreamController<int>.broadcast();
  final _nombreController       =StreamController<String>.broadcast();
  final _passwordController     =StreamController<String>.broadcast();
  final _confirmacionController =StreamController<String>.broadcast();

  //recuperar los datos del Stream
  Stream<int>   get cuiStream          => _cuiController.stream;
  Stream<String>get nombreStream       => _nombreController.stream;
  Stream<String>get passwordStream     => _passwordController.stream;
  Stream<String>get confirmacionStream => _confirmacionController.stream;
  //insertar valores al stream
  Function(int)    get changeCui            => _cuiController.sink.add;
  Function(String) get changeNombre         => _nombreController.sink.add;
  Function(String) get changePassword       => _passwordController.sink.add;
  Function(String) get changeConfirmacion => _confirmacionController.sink.add;
  
  dispose(){
    _cuiController?.close();
    _nombreController?.close();
    _passwordController?.close();
    _confirmacionController?.close();
  }
}