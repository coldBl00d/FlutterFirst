import 'package:flutter/material.dart';
import '../../pages/product.dart';
import './product_card.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products);

  Widget _buildWidgetToRender() {
    Widget renderWidget = ListView.builder(
      itemBuilder: (BuildContext context, int index) => ProductCard(products[index], index),
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
