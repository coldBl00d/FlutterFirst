import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/products/price.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final double price;

  ProductPage(
      {this.title = 'Unknown',
      this.imageUrl = 'assets/food.jpg',
      this.description = 'Nothing yet...',
      this.price = 0.0});

  _showWarningDialogue(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure"),
            content: Text("This action cannot be undone"),
            actions: <Widget>[
              FlatButton(
                child: Text("Discard"),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                  child: Text("Continue"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context, true);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () {
          print("Back button pressed");
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                    title: Text(this.title),
                    background: Image(
                      image: AssetImage('assets/food.jpg'),
                      fit: BoxFit.cover,
                    )),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _showWarningDialogue(context),
                  )
                ],
                floating: true,
              ),
              SliverFixedExtentList(
                itemExtent: 300,
                delegate: SliverChildListDelegate([
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 10.0, right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                PriceTag(this.price.toString()),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[Text(this.description == null ? "Nothing here ... ": this.description)],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              )
            ],
          ),
        ));
  }

  /*@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope( onWillPop: (){
      print("Back button pressed");
      Navigator.pop(context, false);
      return Future.value(false);
    } ,child: Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Column(
        children: <Widget>[
          Image.asset(imageUrl),
          SizedBox(height: 20.0,),
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
  }*/
}

//  class HeroHeader extends SliverPersistentHeaderDelegate{

//     HeroHeader({
//     this.minExtent,
//     this.maxExtent,
//   });

//   double maxExtent;
//   double minExtent;

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }

//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     // TODO: implement build
//     return Image.asset('assets/food.jpg');
//   }
