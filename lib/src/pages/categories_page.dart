import 'package:flutter/material.dart';

import 'package:crud_sqlite/src/models/category_model.dart';
import 'package:crud_sqlite/src/bloc/categorys_bloc.dart';
import 'package:crud_sqlite/src/widgets/menu_widget.dart';

class CategoryPage extends StatelessWidget {
  final categorysBloc = new CategorysBloc();

  @override
  Widget build(BuildContext context) {
    categorysBloc.obtenerCategorias();

    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: categorysBloc.borrarCategorias,
          )
        ],
      ),
      drawer: MenuWidget(),
      body: StreamBuilder<List<CategoryModel>>(
        stream: categorysBloc.categoryStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final categ = snapshot.data;

          if (categ.length == 0) {
            return Center(child: Text('No hay información'));
          }

          return _listaCategorys(categ);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'addcategoria'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _listaCategorys(List<CategoryModel> categ) {
    return ListView.builder(
      itemCount: categ.length,
      itemBuilder: (context, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete),
          color: Colors.red,
        ),
        secondaryBackground: Container(
          alignment: Alignment.centerRight,
          child: Icon(Icons.delete),
          color: Colors.red,
        ),
        onDismissed: (direction) =>
            categorysBloc.borrarCategoriasId(categ[i].id),
        child: item(categ[i], context),
      ),
    );
  }

  item(CategoryModel categ, BuildContext context) {
    return ListTile(
      leading: Icon(Icons.account_balance_wallet,
          color: Theme.of(context).primaryColor),
      title: Text(categ.categoryname),
      subtitle: Text('Id: ${categ.id}'),
      trailing: Icon(Icons.edit, color: Colors.grey),
      onTap: () =>
          Navigator.pushNamed(context, 'addcategoria', arguments: categ),
    );
  }
}
