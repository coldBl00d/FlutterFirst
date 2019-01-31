import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function addProduct;

  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      child: Text("Add Product"),
      onPressed: () {
        //add data here
        addProduct({'title':'Chocolate','image':'assets/food.jpg' });
      },
    );
  }
}
