import 'package:course/scoped-models/main.dart';
import 'package:flutter/material.dart';
import '../pages/product_edit.dart';
//import '../models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ListProduct extends StatefulWidget {
  MainModel model;

  ListProduct({@required this.model});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListProductState();
  }
}

class ListProductState extends State<ListProduct> {
  @override
  void initState() {
    super.initState();
    widget.model.fetchProducts();
  }

  Widget _buildEditButton(BuildContext context, int index) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            final _id = model.getProduct(index:index).id;
            model.setSelectedProductId(_id);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return EditProduct();
                },
              ),
            ).then((_) => model.setSelectedProductId(null));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return widget.model.isLoading
            ? Center(child: CircularProgressIndicator())
            : _buildList();
      },
    );
  }

  Widget _buildList() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.startToEnd) {

                  model.deleteProduct(id:model.getProduct(index: index).id);
                }
              },
              key: Key(model.getProduct(index: index).title),
              background: Container(
                color: Colors.red,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(model.getProduct(index:index).image),
                    ),
                    title: Text(model.getProduct(index:index).title),
                    subtitle: Text('\$${model.getProduct(index:index).price}'),
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
