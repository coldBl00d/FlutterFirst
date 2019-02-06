import 'package:flutter/material.dart';
import './pages/product.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function deleteProduct;

  Products(this.products, {this.deleteProduct});

  //Build a card for product at index
  Widget _getProductCardItem(BuildContext context, int index) => Card(
        child: Column(
          children: <Widget>[
            Image.asset(products[index]['image']),
            Text(products[index]['title']),
            ButtonBar(alignment: MainAxisAlignment.center, children: <Widget>[
              FlatButton(
                child: Text('Detail'),
                onPressed: () => Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ProductPage(
                                title: this.products[index]['title'],
                                imageUrl: this.products[index]
                                    ['image'])) //MaterialPageRoute
                        ).then((bool doDelete) {
                      if (doDelete) {
                        this.deleteProduct(index);
                      }
                    }), //Navigator
              ),
            ] //MaterialPageRouter -- needed for animation
                )
          ],
        ),
      );

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
