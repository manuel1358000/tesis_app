import 'dart:async';
import 'package:alerta_app/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class PublicacionBloc with Validators{
  final _tipoController        = BehaviorSubject<int>();
  final _nombreController      = BehaviorSubject<String>();
  final _descripcionController = BehaviorSubject<String>();
  final _posicionXController   = BehaviorSubject<double>();
  final _posicionYController   = BehaviorSubject<double>();
  final _estadoController      = BehaviorSubject<int>();
  final _subtipoController     = BehaviorSubject<int>();
  final _fechaController     = BehaviorSubject<String>();
  final _horaController     = BehaviorSubject<String>();
  

  //recuperar los datos del Stream
  Stream<int>      get tipoStream        => _tipoController.stream;
  Stream<String>   get nombreStream      => _nombreController.stream.transform(validarTITULO);
  Stream<String>   get descripcionStream => _descripcionController.stream.transform(validarDESCRIPCION);
  Stream<double>   get posicionXStream   => _posicionXController.stream;
  Stream<double>   get posicionYStream   => _posicionYController.stream;
  Stream<int>      get estadoStream      => _estadoController.stream;
  Stream<int>      get subtipoStream     => _subtipoController.stream;
  Stream<String>   get fechaStream       => _fechaController.stream.transform(validarFECHA);
  Stream<String>   get horaStream       => _horaController.stream.transform(validarHORA);

  Stream<bool> get formValidatorEvento=>
          Observable.combineLatest2(nombreStream,descripcionStream,(n,d)=>true);

  //insertar valores al stream
  Function(int)       get changeTipo        => _tipoController.sink.add;
  Function(String)    get changeNombre      => _nombreController.sink.add;
  Function(String)    get changeDescripcion => _descripcionController.sink.add;
  Function(double)    get changePosicionX   => _posicionXController.sink.add;
  Function(double)    get changePosicionY   => _posicionYController.sink.add;
  Function(int)       get changeEstado      => _estadoController.sink.add;  
  Function(int)       get changeSubtipo     => _subtipoController.sink.add;  
  Function(String)       get changeFecha     => _fechaController.sink.add;  
  Function(String)       get changeHora     => _horaController.sink.add;  
  //obtener el ultimo valor ingresado a los textinput
  int    get tipo        =>_tipoController.value;
  String get nombre      =>_nombreController.value;
  String get descripcion =>_descripcionController.value;
  double get posicionX   =>_posicionXController.value;
  double get posicionY   =>_posicionYController.value;
  int    get estado      =>_estadoController.value;
  int    get subtipo     =>_subtipoController.value;
  String get fecha       =>_fechaController.value;
  String get hora       =>_horaController.value;

  set setTipo(int valor)           =>_tipoController.value=valor;
  set setNombre(String valor)      =>_nombreController.value=valor;
  set setDescripcion(String valor) =>_descripcionController.value=valor;
  set setPosicionX(double valor)   =>_posicionXController.value=valor;
  set setPosicionY(double valor)   =>_posicionYController.value=valor;
  set setEstado(int valor)         =>_estadoController.value=valor;
  set setSubtipo(int valor)         =>_subtipoController.value=valor;
  set setFecha(String valor)         =>_fechaController.value=valor;
  set setHora(String valor)         =>_horaController.value=valor;

  dispose(){
    _tipoController?.close();
    _nombreController?.close();
    _descripcionController?.close();
    _posicionXController?.close();
    _posicionYController?.close();
    _estadoController?.close();
    _subtipoController?.close();
    _fechaController?.close();
    _horaController?.close();
  }
}