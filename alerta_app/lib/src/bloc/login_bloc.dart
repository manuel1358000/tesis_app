import 'dart:async';

class LoginBloc{

  final _cuiController      =StreamController<int>.broadcast();
  final _passwordController =StreamController<String>.broadcast();

  //recuperar los datos del Stream
  Stream<int>   get cuiStream      => _cuiController.stream;
  Stream<String>get passwordStream => _passwordController.stream;

  //insertar valores al stream
  Function(int)    get changeCui      => _cuiController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  dispose(){
    _cuiController?.close();
    _passwordController?.close();
  }
}