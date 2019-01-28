import 'package:flutter/material.dart';

/*void main() {
  //provided by material file of flutter package
  runApp(MyApp());
} */

//this is equivalent to above
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  /*
    this is the method used to draw, and is called by flutter
    context is the data passed on by flutter
    context info like color.  

    annotation tells dart and flutter that this is overridden on purpose
  */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //Scaffold create the white page
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('EasyList'),
      ),
      body: Column(
        children: [
          Container(child:RaisedButton(
            child: Text("Add Product"),
            onPressed: () {},
          ),
          margin: EdgeInsets.all(6.0),)
          ,
          Card(
            child: Column(
              children: <Widget>[
                Image.asset('assets/food.jpg'),
                Text('Food Paradise')
              ],
            ),
          )
        ],
      ),
    ));
    //core root widget -- MAterialApp
    //build should always return a widget until it returns a flutter widget.
  }
}
