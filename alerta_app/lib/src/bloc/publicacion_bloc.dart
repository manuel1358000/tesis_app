import 'dart:async';

import 'package:rxdart/rxdart.dart';

class PublicacionBloc{
  final _tipoController        = BehaviorSubject<int>();
  final _nombreController      = BehaviorSubject<String>();
  final _descripcionController = BehaviorSubject<String>();
  final _posicionXController   = BehaviorSubject<double>();
  final _posicionYController   = BehaviorSubject<double>();
  final _estadoController      = BehaviorSubject<int>();
  final _subtipoController     = BehaviorSubject<int>();
  

  //recuperar los datos del Stream
  Stream<int>      get tipoStream        => _tipoController.stream;
  Stream<String>   get nombreStream      => _nombreController.stream;
  Stream<String>   get descripcionStream => _descripcionController.stream;
  Stream<double>   get posicionXStream   => _posicionXController.stream;
  Stream<double>   get posicionYStream   => _posicionYController.stream;
  Stream<int>      get estadoStream      => _estadoController.stream;
  Stream<int>      get subtipoStream     => _subtipoController.stream;
  
  //insertar valores al stream
  Function(int)       get changeTipo        => _tipoController.sink.add;
  Function(String)    get changeNombre      => _nombreController.sink.add;
  Function(String)    get changeDescripcion => _descripcionController.sink.add;
  Function(double)    get changePosicionX   => _posicionXController.sink.add;
  Function(double)    get changePosicionY   => _posicionYController.sink.add;
  Function(int)       get changeEstado      => _estadoController.sink.add;  
  Function(int)       get changeSubtipo     => _subtipoController.sink.add;  
  
  //obtener el ultimo valor ingresado a los textinput
  int    get tipo        =>_tipoController.value;
  String get nombre      =>_nombreController.value;
  String get descripcion =>_descripcionController.value;
  double get posicionX   =>_posicionXController.value;
  double get posicionY   =>_posicionYController.value;
  int    get estado      =>_estadoController.value;
  int    get subtipo      =>_subtipoController.value;


  set setTipo(int valor)           =>_tipoController.value=valor;
  set setNombre(String valor)      =>_nombreController.value=valor;
  set setDescripcion(String valor) =>_descripcionController.value=valor;
  set setPosicionX(double valor)   =>_posicionXController.value=valor;
  set setPosicionY(double valor)   =>_posicionYController.value=valor;
  set setEstado(int valor)         =>_estadoController.value=valor;
  set setSubtipo(int valor)         =>_subtipoController.value=valor;

  dispose(){
    _tipoController?.close();
    _nombreController?.close();
    _descripcionController?.close();
    _posicionXController?.close();
    _posicionYController?.close();
    _estadoController?.close();
    _subtipoController?.close();
  }
}