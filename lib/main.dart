import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/auth.dart';
import './pages/manage_products.dart';
import './pages/product.dart';
import './pages/products.dart';
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
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _mainModel = MainModel();
  bool isAuthenticated = false;
  /* 
   * Login the user if token exist in the shared preference 
   * */
  @override
  void initState() {
    _mainModel.autoAuthenticate();
    _mainModel.userSubject.listen((bool isAuthenticated) {
      print("Authentication event consumed with value " +
          isAuthenticated.toString());
      setState(() {
        this.isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Main build execution starts");
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
          '/': (BuildContext context) =>
              isAuthenticated == true ? ProductsPage(_mainModel) : AuthPage(),
          //'/products': (BuildContext context) => ProductsPage(_mainModel),
          '/admin': (BuildContext context) => isAuthenticated
              ? ManageProductsPage(model: _mainModel)
              : AuthPage(),
          // '/product':(BuildContext context) => ProductPage()
        },
        onGenerateRoute: (RouteSettings settings) {
          //?a function that will be called when we navigate to a named route which is not registered in the routes registery
          //*To protect these routes
          
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
                return isAuthenticated?ProductPage(model: _mainModel):AuthPage();
              },
            );
          }
        },

        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (BuildContext context) {
            return isAuthenticated?ProductsPage(_mainModel):AuthPage();
          });
        },
      ),
    );

    //core root widget -- MAterialApp
    //build should always return a widget until it returns a flutter widget.
  }
}
