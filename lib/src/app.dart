import 'package:flutter/material.dart';

import 'package:crud_sqlite/src/pages/home_page.dart';
import 'package:crud_sqlite/src/pages/categories_page.dart';
import 'package:crud_sqlite/src/pages/categori_add_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crud Sqflite',
      initialRoute: 'categorias',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'categorias': (BuildContext context) => CategoryPage(),
        'addcategoria': (BuildContext context) => CategoryAddPage(),
      },
      theme: ThemeData(primaryColor: Colors.green),
    );
  }
}
