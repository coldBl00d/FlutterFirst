import 'package:flutter/material.dart';
import './price.dart';
import '../ui_elements/title_default.dart';
import '../ui_elements/address_tag.dart';
import '../../models/Product.dart';
import '../../scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final String productId;

  ProductCard(this.product, this.productId);

  Widget _buildTitlePriceRow() {
    return Container(
      //color: Colors.red,
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(product.title),
          SizedBox(
            width: 8.0,
          ),
          PriceTag(this.product.price.toString()),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return ButtonBar(alignment: MainAxisAlignment.center, children: <Widget>[
      IconButton(
        color: Theme.of(context).primaryColor,
        icon: Icon(
          Icons.info,
        ),
        onPressed: () =>
            Navigator.pushNamed<bool>(context, '/product/' + productId)
                .then((bool doDelete) {
              if (doDelete) {
                //this.deleteProduct(index);
              }
            }), //Navigator
      ),
      SizedBox(
        width: 5.0,
      ),
      ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          Icon heartIcon = Icon(Icons.favorite_border);
          if (model.getProduct(id:this.product.id).isFavorite)
            heartIcon = Icon(Icons.favorite);
          return IconButton(
            color: Colors.red,
            icon: heartIcon,
            onPressed: () {
              // model.selectProduct(index);
              debugPrint("Toggling favorite of product id "+ productId);
              model.toggleProductFavorite(productId, unsetSelectedProduct: true);
            },
          );
        },
      )
    ] //MaterialPageRouter -- needed for animation
        );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(product.image),
            height: 300,
            fit:BoxFit.cover,
            placeholder: AssetImage('assets/food.jpg'),
          ),
          this._buildTitlePriceRow(),
          AddressTag(), //Add address as parameter
          this._buildButtons(context)
        ],
      ),
    );
  }
}
