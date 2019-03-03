import 'package:flutter/material.dart';

import './product_edit.dart';
import './product_list.dart';
import '../widgets/my_drawer.dart';

import '../scoped-models/main.dart';


/*
  Manage product -- Create product and My Product Tabs
*/ 
class ManageProductsPage extends StatefulWidget {
  MainModel model; 

  ManageProductsPage({@required this.model});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ManageProductState();
  }

}  

class ManageProductState extends State<ManageProductsPage>{


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
              this._buildCreateProductTab(),
              this._buildMyProductTab(),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            //should be equal to the number of tabs ^ length
            EditProduct(),
            ListProduct(model: widget.model),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateProductTab() {
    return Tab(
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
    );
  }

  Widget _buildMyProductTab() {
    return Tab(
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
    );
  }
}
