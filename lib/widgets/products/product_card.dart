import 'package:flutter/material.dart';
import './price.dart';
import '../ui_elements/title_default.dart';
import '../ui_elements/address_tag.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int index;

  ProductCard(this.product, this.index);

  Widget _buildTitlePriceRow(){
    return Container(
            //color: Colors.red,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleDefault(product['title']),
                SizedBox(
                  width: 8.0,
                ),
                PriceTag(this.product['price'].toString()),
              ],
            ),
          );
  }

  Widget _buildButtons(BuildContext context){
    return ButtonBar(alignment: MainAxisAlignment.center, children: <Widget>[
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(
                Icons.info,
              ),
              onPressed: () => Navigator.pushNamed<bool>(
                          context, '/product/' + index.toString())
                      .then((bool doDelete) {
                    if (doDelete) {
                      //this.deleteProduct(index);
                    }
                  }), //Navigator
            ),
            SizedBox(
              width: 5.0,
            ),
            IconButton(
              color: Colors.red,
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
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
          Image.asset(product['image']),
          this._buildTitlePriceRow(),
          AddressTag(), //Add address as parameter
          this._buildButtons(context) 
        ],
      ),
    );
  }
}
