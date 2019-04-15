import 'package:flutter/material.dart';
import './pages/auth.dart';
import 'package:flutter/rendering.dart';
import './pages/manage_products.dart';
import './pages/products.dart';
import './pages/product.dart';
import './models/Product.dart';
import 'package:scoped_model/scoped_model.dart';

import './scoped-models/main.dart';
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
  final MainModel _mainModel = MainModel();
  /**
   * Login the user if token exist in the shared preference 
   * */
  @override
  void initState() {
    // TODO: implement initState
    _mainModel.autoAuthenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //Scaffold create the white pag
    return ScopedModel<MainModel>(
      model: _mainModel,
      child: MaterialApp(
        theme: ThemeData(
            //brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.pinkAccent,
            buttonColor: Colors.pinkAccent),
        //home: AuthPage(),
        //represents home --> either have this or home argument in the material app
        routes: {
          '/': (BuildContext context) => _mainModel.authenticatedUser != null?ProductsPage(_mainModel):AuthPage(),
          '/products': (BuildContext context) => ProductsPage(_mainModel),
          '/admin': (BuildContext context) =>
              ManageProductsPage(model: _mainModel),
          // '/product':(BuildContext context) => ProductPage()
        },
        onGenerateRoute: (RouteSettings settings) {
          //a function that will be called when we navigate to a named route which is not registered in the routes registery
          final List<String> pathElement = settings.name.split('/');
          if (pathElement[0] != '') {
            //this will not load any page
            return null;
          }
          if (pathElement[1] == 'product') {
            final String productId = pathElement[2];
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) {
                _mainModel.setSelectedProductId(productId);
                return ProductPage(model: _mainModel);
              },
            );
          }
        },

        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (BuildContext context) {
            return ProductsPage(_mainModel);
          });
        },
      ),
    );

    //core root widget -- MAterialApp
    //build should always return a widget until it returns a flutter widget.
  }
}
