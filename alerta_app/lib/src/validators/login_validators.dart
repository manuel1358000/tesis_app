import 'dart:async';
class Validators{
  final validarCUI=StreamTransformer<int,int>.fromHandlers(
    handleData: (cui,sink){
      if(cui.toString().length!=0){
        sink.add(cui);
      }else{
        sink.addError('Ingrese un CUI valido');
        
      }
    }
  );
  final validarContra=StreamTransformer<String,String>.fromHandlers(
    handleData: (contra,sink){
      if(contra!=''){
        sink.add(contra);
      }else{
        sink.addError('Ingrese una contraseña');
      }
    }
  );
}