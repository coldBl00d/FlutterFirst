import 'package:flutter/material.dart';
import './product_manager.dart';
import './pages/home.dart';
import 'package:flutter/rendering.dart';

/*void main() {
  //provided by material file of flutter package
  runApp(MyApp());
} */

//this is equivalent to above
void main(){  
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
        home: HomePage());
    //core root widget -- MAterialApp
    //build should always return a widget until it returns a flutter widget.
  }
}
