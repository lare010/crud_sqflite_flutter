import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:crud_sqlite/src/models/category_model.dart';
import 'package:crud_sqlite/src/widgets/menu_widget.dart';
import 'package:crud_sqlite/src/bloc/categorys_bloc.dart';
import 'package:crud_sqlite/src/bloc/add_category_bloc.dart';

class CategoryAddPage extends StatefulWidget {
  @override
  _CategoryAddPageState createState() => _CategoryAddPageState();
}

class _CategoryAddPageState extends State<CategoryAddPage> {
  final categorysBloc = new CategorysBloc();

  final addCategoryBloc = new AddCategoryBloc();

  CategoryModel categoria = new CategoryModel();

  @override
  Widget build(BuildContext context) {
    final CategoryModel catgData = ModalRoute.of(context).settings.arguments;

    if (catgData != null) {
      categoria = catgData;
    } else {
      categoria.categoryname = '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Categoria'),
      ),
      drawer: MenuWidget(),
      body: _formAddCategory(context),
    );
  }

  Widget _formAddCategory(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: addCategoryBloc.categoria,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: TextFormField(
                  initialValue: categoria.categoryname,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    icon: Icon(Icons.assignment_ind),
                    // hintText: 'Categoria',
                    labelText: 'Categoria',
                    errorText: snapshot.error,
                  ),
                  onChanged: addCategoryBloc.chageCategory,
                ),
              );
            },
          ),
          StreamBuilder(
            stream: addCategoryBloc.categoria,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return RaisedButton(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                  child: Text('Salvar'),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 0.0,
                color: Colors.blueGrey,
                textColor: Colors.white,
                onPressed: snapshot.hasData
                    ? () => _crearCategory(context, snapshot.data)
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }

  _crearCategory(BuildContext context, String data) async {
    int registro;
    if (categoria.id != null) {
      final catg = CategoryModel(categoryname: data, id: categoria.id);
      registro = await categorysBloc.actualizarCategoria(catg);
      if (registro != 0) {
        mostrarAlerta(context, "Registro Actualizado Correctamente");
      }
    } else {
      final catg = CategoryModel(categoryname: data);
      registro = await categorysBloc.crearCategorias(catg);

      if (registro != 0) {
        mostrarAlerta(context, "Registro Guardado Correctamente");
      }
    }
  }

  void mostrarAlerta(BuildContext context, String mensaje) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text(
              ' ',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            content: Text(mensaje,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                textAlign: TextAlign.center),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'categorias');
                  },
                  child: Text(
                    'Aceptar',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ))
            ],
          );
        });
  }
}
