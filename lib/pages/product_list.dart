import 'package:flutter/material.dart';

class ListProduct extends StatelessWidget {
  final List<Map<String, dynamic>> _products;

  ListProduct(this._products);

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildll;
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Container(
              height: 40,
              width: 100,
              child: Image.asset(this._products[index]['image']),
            ),
            title: Text(this._products[index]['title']),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          );
        },
        itemCount: this._products.length,
      ),
    );
  }
}
