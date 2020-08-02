import 'dart:async';

import 'package:crud_sqlite/src/bloc/validators.dart';

class AddCategoryBloc with Validators {
  final _categoria = StreamController<String>.broadcast();

  //recuperar inf del stream
  Stream<String> get categoria => _categoria.stream.transform(validarCategory);

  //insertar valores al stream
  Function(String) get chageCategory => _categoria.sink.add;

  dipsose() {
    _categoria?.close();
  }
}
