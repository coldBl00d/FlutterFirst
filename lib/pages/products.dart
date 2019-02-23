import 'package:flutter/material.dart';
import './manage_products.dart';
import '../widgets/my_drawer.dart';
import '../widgets/products/products.dart';
import '../models/Product.dart';

class ProductsPage extends StatelessWidget {
  //final List<Product> _products;
  //final Function _addProduct;
  //final Function _deleteProduct;

  //ProductsPage(this._products, this._addProduct, this._deleteProduct );

  Drawer _buildSideDrawer(BuildContext context){
    return Drawer(
        //child: MyDrawer()
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text("Choose"),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Manage Products"),
              onTap: () {
                //named navigation
                Navigator.pushReplacementNamed(context, '/admin');
                /*un named navigation
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                return ManageProductsPage();
              }));*/
              },
            )
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: this._buildSideDrawer(context),
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          )
        ],
      ),
      body: Products(),
    );
  }
}
