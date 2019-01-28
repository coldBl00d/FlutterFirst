import 'package:flutter/material.dart';
import './products.dart';

class ProductManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  final List<String> _products = ["first"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: [
      Container(
        margin: EdgeInsets.all(6.0),
        child: RaisedButton(
          child: Text("Add Product"),
          onPressed: () {
            //add data here
            setState(() {
              _products.add("Lambo");
            });
          },
        ),
      ),
      Products(_products)
    ]);
  }
}
