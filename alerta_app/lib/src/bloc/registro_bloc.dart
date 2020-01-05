import 'dart:async';
import 'package:alerta_app/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';
class RegistroBloc with Validators{

  final _cuiController          =BehaviorSubject<int>();
  final _nombreController       =BehaviorSubject<String>();
  final _passwordController     =BehaviorSubject<String>();
  final _confirmacionController =BehaviorSubject<String>();

  //recuperar los datos del Stream
  Stream<int>   get cuiStream          => _cuiController.stream.transform(validarCUI);
  Stream<String>get nombreStream       => _nombreController.stream.transform(validarNOMBRE);
  Stream<String>get passwordStream     => _passwordController.stream.transform(validarCONTRA);
  Stream<String>get confirmacionStream => _confirmacionController.stream.transform(validarCONFIRMACION);
  
 Stream<bool> get formValidator2=>
          Observable.combineLatest4(cuiStream, nombreStream,passwordStream,confirmacionStream,(c,n,p,t)=>true);

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