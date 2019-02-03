import 'package:flutter/material.dart';
import '../pages/manage_products.dart';
import '../pages/products.dart';

class MyDrawer extends StatelessWidget{

  MyDrawer();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text("Choose"),
          
        ),
        ListTile(title: Text("All Products"), onTap: () {
          Navigator.pushReplacementNamed(context, '/products');
        },),
      ],
    );
  }
}