import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {

  final String title;
  final String imageUrl;


  ProductPage({this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                color:Theme.of(context).accentColor,
                child: Text('Back', style: TextStyle(color: Colors.white70),),
                onPressed: () => Navigator.pop(context),
              ))
        ],
      ),
    );
  }
}
