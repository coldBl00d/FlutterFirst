import 'package:flutter/material.dart';
import './manage_products.dart';
import '../widgets/my_drawer.dart';
import '../widgets/products/products.dart';
import '../models/Product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

class ProductsPage extends StatefulWidget {
  //final List<Product> _products;
  //final Function _addProduct;
  //final Function _deleteProduct;

  //ProductsPage(this._products, this._addProduct, this._deleteProduct );

  final MainModel _model; 

  ProductsPage(this._model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductsPageState();
  }
}

class ProductsPageState extends State<ProductsPage>{

  @override
  initState(){
    super.initState();
    widget._model.fetchProducts();
  }
  
  Drawer _buildSideDrawer(BuildContext context) {
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

  Widget _buildSpinner(){
    return Center(
      child: CircularProgressIndicator(
        value: null, 
        backgroundColor: Colors.blue,
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
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.favoriteMode?Icons.favorite:Icons.favorite_border),
                onPressed: () {
                  model.toggleDisplayMode();
                },
              );
            },
          ),
        ],
      ),
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model){
          if(model.isLoading){
            return _buildSpinner();
          }else{
            return Products();
          }
        },
      )
    );
  }
}
