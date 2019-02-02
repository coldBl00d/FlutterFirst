import 'package:flutter/material.dart';
import '../pages/manage_products.dart';
import '../pages/products.dart';

class MyDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        AppBar(
          title: Text("Choose"),
          
        ),
        ListTile(title: Text("All Products"), onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (BuildContext context){
              return ProductsPage();
            }
          ));
        },),
      ],
    );
  }
}