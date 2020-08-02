import 'dart:async';

import 'package:crud_sqlite/src/providers/db_provider.dart';

class CategorysBloc {
  static final CategorysBloc _singuelton = new CategorysBloc._();

  factory CategorysBloc() {
    return _singuelton;
  }

  CategorysBloc._() {
    //obtener las categorias
    obtenerCategorias();
  }

  final _categoryController = StreamController<List<CategoryModel>>.broadcast();

  Stream<List<CategoryModel>> get categoryStream => _categoryController.stream;

  disponse() {
    _categoryController?.close();
  }

  //obtener categorias
  obtenerCategorias() async {
    _categoryController.sink.add(await DBProvider.db.getCategory());
  }

  //crear categorias
  Future<int> crearCategorias(CategoryModel catg) async {
    int id = await DBProvider.db.newCategory(catg);
    obtenerCategorias();
    return id;
  }

  //actualizar registros
  Future<int> actualizarCategoria(CategoryModel catg) async {
    int id = await DBProvider.db.updateCategory(catg);
    obtenerCategorias();
    return id;
  }

  //borrar categorias por id
  borrarCategoriasId(int id) async {
    await DBProvider.db.deleteCategoryId(id);
    obtenerCategorias();
  }

  //borrar todas las categorias
  borrarCategorias() async {
    await DBProvider.db.deleteCategory();
    obtenerCategorias();
  }
}
