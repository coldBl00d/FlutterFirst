import 'package:flutter/material.dart';
import '../../pages/product.dart';
import './price.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products);

  //Build a card for product at index
  Widget _getProductCardItem(BuildContext context, int index) => Card(
        child: Column(
          children: <Widget>[
            Image.asset(products[index]['image']),
            Container(
              //color: Colors.red,
              
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text(products[index]['title'], style: TextStyle(fontSize: 26.0,fontWeight: FontWeight.bold, fontFamily: 'Oswald'),),
                SizedBox(width: 8.0,),
                PriceTag(this.products[index]['price'].toString()),
                
              ],),  
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 6.0),
              child: Text("Union Square, San Franscisco"),
              decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(5.0)
            ),),
            ButtonBar(alignment: MainAxisAlignment.center, children: <Widget>[
              IconButton(
                color: Theme.of(context).primaryColor,
                icon: Icon(Icons.info,),
                onPressed: () => Navigator.pushNamed<bool>(context, '/product/'+index.toString()).then((bool doDelete) {
                      if(doDelete){
                        //this.deleteProduct(index);
                      }
                    }), //Navigator
              ),
              SizedBox(width: 5.0,),
              IconButton(
                color: Colors.red,icon: Icon(Icons.favorite_border), onPressed: (){},)
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
