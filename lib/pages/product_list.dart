import 'package:flutter/material.dart';
import '../pages/product_edit.dart';
import '../models/Product.dart';

class ListProduct extends StatelessWidget {
  final List<Product> _products;
  final Function _updateProduct;
  final Function _deleteProduct;

  ListProduct(this._products, this._updateProduct, this._deleteProduct);

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return EditProduct(
                product: this._products[index],
                updateProduct: this._updateProduct,
                index: index,
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildll;
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                this._deleteProduct(index);
              }
            },
            key: Key(_products[index].title),
            background: Container(
              color: Colors.red,
            ),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(this._products[index].image),
                  ),
                  title: Text(this._products[index].title),
                  subtitle: Text('\$${this._products[index].price}'),
                  trailing: this._buildEditButton(context, index),
                 ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: this._products.length,
      ),
    );
  }
}
