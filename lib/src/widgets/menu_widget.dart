import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Container(),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/menu-img.jpg'),
            fit: BoxFit.cover,
          )),
        ),
        ListTile(
            leading: Icon(Icons.home, color: Colors.blue),
            title: Text('Home'),
            onTap: () => Navigator.pushReplacementNamed(context, 'home')),
        Divider(),
        ListTile(
            leading: Icon(Icons.pages, color: Colors.blue),
            title: Text('Categorias'),
            onTap: () => Navigator.pushReplacementNamed(context, 'categorias')),
        Divider(),
        ListTile(
            leading: Icon(Icons.add_to_photos, color: Colors.blue),
            title: Text('Agregar Categorias'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, 'addcategoria')),
      ],
    ));
  }
}
