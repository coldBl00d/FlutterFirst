import 'package:flutter/material.dart';
import './pages/auth.dart';
import 'package:flutter/rendering.dart';
import './pages/manage_products.dart';
import './pages/products.dart';
import './pages/product.dart';

/*void main() {
  //provided by material file of flutter package
  runApp(MyApp());
} */

//this is equivalent to above
void main() {
  //debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> newProduct) {
    setState(() {
      this._products.add(newProduct);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      this._products.removeAt(index);
    });
  }

  void _updateProduct(int index, Map<String, dynamic> newData){
    setState(() {
      this._products[index] = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //Scaffold create the white page
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.pinkAccent,
          buttonColor: Colors.pinkAccent
          ),
      //home: AuthPage(),
      routes: {
        '/': (BuildContext context) =>
            AuthPage(), //represents home --> either have this or home argument in the material app
        '/products': (BuildContext context) => ProductsPage(this._products),
        '/admin': (BuildContext context) =>
            ManageProductsPage(this._addProduct, this._updateProduct, this._deleteProduct, this._products),
        //'/product':(BuildContext context) => ProductPage()
      },
      onGenerateRoute: (RouteSettings settings) {
        //a function that will be called when we navigate to a named route which is not registered in the routes registery
        final List<String> pathElement = settings.name.split('/');
        if (pathElement[0] != '') {
          //this will not load any page
          return null;
        }
        if (pathElement[1] == 'product') {
          final int index = int.parse(pathElement[2]);
          return MaterialPageRoute<bool>(builder: (BuildContext context) {
            return ProductPage(
              title: this._products[index]['title'],
              imageUrl: this._products[index]['image'],
              description: this._products[index]['desc'],
              price: this._products[index]['price'],
            );
          });
        }
      },

      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return ProductsPage(_products);
        });
      },
    );
    //core root widget -- MAterialApp
    //build should always return a widget until it returns a flutter widget.
  }
}
