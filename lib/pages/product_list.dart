import 'package:course/scoped-models/main.dart';
import 'package:flutter/material.dart';
import '../pages/product_edit.dart';
//import '../models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ListProduct extends StatelessWidget {
  Widget _buildEditButton(BuildContext context, int index) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            model.selectProduct(index);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return EditProduct();
                },
              ),
            ).then((_) => model.setSelectedIndex(null));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildll;
    return Padding(
      padding: EdgeInsets.all(10),
      child: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.startToEnd) {
                  model.deleteProduct(index);
                }
              },
              key: Key(model.getProduct(index).title),
              background: Container(
                color: Colors.red,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage(model.getProduct(index).image),
                    ),
                    title: Text(model.getProduct(index).title),
                    subtitle: Text('\$${model.getProduct(index).price}'),
                    trailing: this._buildEditButton(context, index),
                  ),
                  Divider(),
                ],
              ),
            );
          },
          itemCount: model.getProductCount(),
        );
      }),
    );
  }
}
