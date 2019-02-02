import 'package:flutter/material.dart';
import '../product_manager.dart';
import '../pages/products.dart';

class AuthPage extends StatelessWidget {

  Widget generateAuthPage(context){

    return Scaffold(appBar: 
      AppBar(
        title: Text("Please enter your credentials"),
      ),
      body: Center(
        child:RaisedButton(
          child:Text("Login"),
          onPressed: () {
            Navigator.pushReplacementNamed(context,'/');
          },)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return this.generateAuthPage(context);
  }

}