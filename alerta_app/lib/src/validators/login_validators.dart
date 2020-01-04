import 'dart:async';
class Validators{
  final validarContra=StreamTransformer<String,String>.fromHandlers(
    handleData: (contra,sink){
      if(contra.length>=6){
        sink.add(contra);
      }else{
        sink.addError('Mas de 6 caracteres por favor');
      }
    }
  );
  final validarCUI=StreamTransformer<int,int>.fromHandlers();
}