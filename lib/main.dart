import 'package:flutter/material.dart';
import './product_manager.dart';

/*void main() {
  //provided by material file of flutter package
  runApp(MyApp());
} */

//this is equivalent to above
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //Scaffold create the white page
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('EasyList'),
      ),
      body: ProductManager("First"),
    ));
    //core root widget -- MAterialApp
    //build should always return a widget until it returns a flutter widget.
  }
}
