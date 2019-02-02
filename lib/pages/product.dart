import 'package:flutter/material.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage({this.title='Unknown', this.imageUrl='assets/food.jpg'});

  _showWarningDialogue(BuildContext context){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Are you sure"),
          content: Text("This action cannot be undone"),
          actions: <Widget>[
            FlatButton(child: Text("Discard"), onPressed: () => Navigator.pop(context),),
            FlatButton(child: Text("Continue"), 
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              }
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope( onWillPop: (){
      print("Back button pressed");
      Navigator.pop(context, false);
      return Future.value(false);
    } ,child: Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Column(
        children: <Widget>[
          Image.asset(imageUrl),
          Container(padding: EdgeInsets.all(10.0), child: Text(this.title)),
          Container(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white70),
                ),
                onPressed: () =>_showWarningDialogue(context) //=> Navigator.pop(context, true),
              ))
        ],
      ),
    ));
  }
}
