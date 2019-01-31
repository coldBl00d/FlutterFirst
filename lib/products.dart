import 'package:flutter/material.dart';
import './pages/product.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> products;

  Products({this.products = const []});

  //Build a card for product at index
  Widget _getProductCardItem(BuildContext context, int index) => Card(
          child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Text(products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProductPage(
                            title: this.products[index]['title'],
                            imageUrl: this.products[index][
                                'image']))), //MaterialPageRouter -- needed for animation
              )
            ],
          )
        ],
      ));

  Widget _buildWidgetToRender() {
    Widget renderWidget = ListView.builder(
      itemBuilder: _getProductCardItem,
      itemCount: products.length,
    );

    if (products.length <= 0) {
      renderWidget = Center(
        child: Text('No Data'),
      );
    }

    return renderWidget;
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgetToRender();
  }
}
