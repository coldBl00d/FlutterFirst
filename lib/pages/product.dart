import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/products/price.dart';
import '../widgets/ui_elements/title_default.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import '../models/Product.dart';

class ProductPage extends StatelessWidget {
  final MainModel model;

  ProductPage({@required this.model});

  _showWarningDialogue(BuildContext context, String id) {
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
                    model.deleteProduct(id:id).then((_) {
                    });
                    Navigator.pop(context);
                    Navigator.pop(context, true);
                  })
            ],
          );
        });
  }

  Widget _buildContent(
      BuildContext context, Product product) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.40,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              //title: TitleDefault(products[index].title),
              background: Image(
                image: NetworkImage(product.image),
                fit: BoxFit.cover,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _showWarningDialogue(context, product.id),
              ),
            ],
            //floating: true,
          ),
          SliverFixedExtentList(
            itemExtent: MediaQuery.of(context).size.height * 0.60,
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment(-1, -1),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Chocolate', //products[index].title,
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Oswald',
                            ),
                          ),
                          Card(
                            shape: CircleBorder(),
                            child: IconButton(
                              icon: Icon(product.isFavorite?Icons.favorite:Icons.favorite_border),
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                model.toggleProductFavorite(product.id, unsetSelectedProduct: false); // TODO Improve toggleProductFavorite by not disselecting the current product in the model if from here.
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              '\$${product.price.toString()}', //products[index].title,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.grey.shade900),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 200,
                              child: Card(
                                color: Colors.blue[30],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child:
                                              Text("${product.desc}", style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black87,
                                              ),),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Container(
  //                 padding: EdgeInsets.all(10.0),
  //                 child: Card(
  //                   child: Column(
  //                     children: <Widget>[
  //                       Container(
  //                         padding: EdgeInsets.only(top: 10.0, right: 20.0),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           children: <Widget>[
  //                             PriceTag(products[index].price.toString()),
  //                           ],
  //                         ),
  //                       ),
  //                       Container(
  //                         padding: EdgeInsets.all(10),
  //                         child: Column(
  //                           children: <Widget>[
  //                             Text(products[index].desc == null
  //                                 ? "Nothing here ... "
  //                                 : products[index].desc),
  //                           ],
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               )

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    

    return WillPopScope(
      onWillPop: () {
        
        model!=null?model.setSelectedProductId(null):debugPrint("[Product Page] Encountered null model when trying to reset selected product on back button");
        print("Back button pressed");
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          //this.model = model;
          return _buildContent(
              context, model.getSelectedProduct());
        },
      ),
    );
  }
}
