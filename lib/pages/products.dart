import 'package:flutter/material.dart';
import '../product_manager.dart';
import './manage_products.dart';
import '../widgets/my_drawer.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> _products;
  //final Function _addProduct;
  //final Function _deleteProduct;
  
  ProductsPage(this._products);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
        //child: MyDrawer()
        child: Column(
          children: <Widget>[
            AppBar(title: Text("Choose"),automaticallyImplyLeading: false,),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Manage Products"),onTap: (){
              //named navigation
              Navigator.pushReplacementNamed(context, '/admin');
              /*un named navigation
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                return ManageProductsPage();
              }));*/
            },)
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite), onPressed: () {},)
        ],
      ),
      body: ProductManager(this._products),
    );
  }
}
