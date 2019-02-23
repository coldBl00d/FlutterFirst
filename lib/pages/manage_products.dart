import 'package:flutter/material.dart';
import '../widgets/my_drawer.dart';
import './product_edit.dart';
import './product_list.dart';

class ManageProductsPage extends StatelessWidget {
  final Function _addProduct;
  final Function _deleteProduct;
  final List<Map<String, dynamic>> _products;

  ManageProductsPage(this._addProduct, this._deleteProduct, this._products);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2, //number of tab
        child: Scaffold(
          //To add tabs wrap scaffold with defaultTabController
          drawer: Drawer(child: MyDrawer()),
          appBar: AppBar(
            title: Text("Manage Products"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Icon(Icons.create)],
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Text("Create Product")],
                      ))
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Icon(Icons.list)],
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Text("My Products")],
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              //should be equal to the number of tabs ^ length
              EditProduct(addProduct: this._addProduct),
              ListProduct(this._products),
            ],
          ),
        ));
  }
}
