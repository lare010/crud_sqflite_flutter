import 'dart:async';

class Validators {
  final validarCategory = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length > 2) {
        sink.add(data);
      } else {
        sink.addError('Categoria Invalida');
      }
    },
  );
}
