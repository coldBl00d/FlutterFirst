import 'package:flutter/material.dart';
import '../pages/product_edit.dart';

class ListProduct extends StatelessWidget {
  final List<Map<String, dynamic>> _products;
  final Function _updateProduct;

  ListProduct(this._products, this._updateProduct);

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
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return EditProduct(product: this._products[index], updateProduct: this._updateProduct, index: index,);
                  },
                ));
              },
            ),
          );
        },
        itemCount: this._products.length,
      ),
    );
  }
}
