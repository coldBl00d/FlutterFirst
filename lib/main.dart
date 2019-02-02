import 'package:flutter/material.dart';
import './pages/auth.dart';
import 'package:flutter/rendering.dart';
import './pages/manage_products.dart';
import './pages/products.dart';

/*void main() {
  //provided by material file of flutter package
  runApp(MyApp());
} */

//this is equivalent to above
void main() {
  //debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //Scaffold create the white page
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light, primarySwatch: Colors.deepPurple),
        //home: AuthPage(),
        routes: {
          '/': (BuildContext context) => ProductsPage(), //represents home --> either have this or home argument in the material app
          '/admin': (BuildContext context) => ManageProductsPage(),
        },
        );
    //core root widget -- MAterialApp
    //build should always return a widget until it returns a flutter widget.
  }
}
