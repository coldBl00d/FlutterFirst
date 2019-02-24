import 'package:flutter/material.dart';
import '../../pages/product.dart';
import './product_card.dart';
import '../../models/Product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped-models/Products.dart';

class Products extends StatelessWidget {
  //final List<Product> products;

  //Products(this.products);

  Widget _buildWidgetToRender(List<Product> products) {
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
    return ScopedModelDescendant<ProductsModel> (builder: (BuildContext context, Widget child, ProductsModel model) {
      //executed whern data is changed. 
      return _buildWidgetToRender(model.displayedProducts);
    },); //  
  }
}
