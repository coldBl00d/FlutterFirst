import 'package:flutter/material.dart';
import '../product_manager.dart';
import './manage_products.dart';
import '../widgets/my_drawer.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
        //child: MyDrawer()
        child: Column(
          children: <Widget>[
            AppBar(title: Text("Choose"),automaticallyImplyLeading: false,),
            ListTile(title: Text("Manage Products"),onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                return ManageProductsPage();
              }));
            },)
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ProductManager(),
    );
  }
}
