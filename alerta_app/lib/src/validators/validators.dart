import 'dart:async';
class Validators{
  final validarCUI=StreamTransformer<int,int>.fromHandlers(
    handleData: (cui,sink){
      if(cui.toString().length>3){
        sink.add(cui);
      }else{
        sink.addError('Ingrese un CUI valido');
        
      }
    }
  );
  final validarNOMBRE=StreamTransformer<String,String>.fromHandlers(
    handleData: (nombre,sink){
      if(nombre!=''){
        sink.add(nombre);
      }else{
        sink.addError('Ingrese un nombre valido');
        
      }
    }
  );

  final validarCONTRA=StreamTransformer<String,String>.fromHandlers(
    handleData: (contra,sink){
      if(contra!=''){
        sink.add(contra);
      }else{
        sink.addError('Ingrese una contraseña');
      }
    }
  );
  final validarCONFIRMACION=StreamTransformer<String,String>.fromHandlers(
    handleData: (confirmacion,sink){
      if(confirmacion!=''){
        sink.add(confirmacion);
      }else{
        sink.addError('Ingrese una contraseña');
      }
    }
  );
  
  final validarFECHA=StreamTransformer<String,String>.fromHandlers(
    handleData: (fecha,sink){
      if(fecha!=''){
        sink.add(fecha);
      }else{
        sink.addError('Ingrese una fecha valida');
        
      }
    }
  );
  final validarHORA=StreamTransformer<String,String>.fromHandlers(
    handleData: (hora,sink){
      if(hora!=''){
        sink.add(hora);
      }else{
        sink.addError('Ingrese una hora valida');
      }
    }
  );
  final validarTITULO=StreamTransformer<String,String>.fromHandlers(
    handleData: (titulo,sink){
      if(titulo!=''){
        sink.add(titulo);
      }else{
        sink.addError('Ingrese un titulo');
      }
    }
  );
  final validarDESCRIPCION=StreamTransformer<String,String>.fromHandlers(
    handleData: (descripcion,sink){
      if(descripcion!=''){
        sink.add(descripcion);
      }else{
        sink.addError('Ingrese una descripcion');
      }
    }
  );
}