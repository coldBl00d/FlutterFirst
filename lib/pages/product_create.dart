import 'package:flutter/material.dart';

class CreateProduct extends StatefulWidget {

  Function _addProduct;

  CreateProduct(this._addProduct);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CreateProductState();
  }
}

class CreateProductState extends State<CreateProduct>{
  
  String _name;
  double _price; 
  String _desc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildll;
    return Container( 
      margin: EdgeInsets.all(20.0),
      child: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
            labelText: 'Title',
            //icon: Icon(Icons.edit)
          ),
          onChanged: (String i){
            // setState(() {
             this._name = i;
            //});
          },),
        
          TextField(
            decoration: InputDecoration(
              labelText: 'Price',
            //icon: Icon(Icons.edit)
            ),
            onChanged: (String i){
              this._price = double.parse(i);
            },
            keyboardType: TextInputType.number,
          ),
        
          TextField(
            decoration: InputDecoration(
              labelText: 'Description',
            //icon: Icon(Icons.edit)
            ),
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            onChanged: (String i) => this._desc = i
          ),

          SizedBox(height: 20.0,),

          RaisedButton(
            textColor: Colors.white70,
            child: Text(
              "Save",
              ),
            onPressed: () {
              final Map<String, dynamic> product = {
                'title':this._name,
                'desc':this._desc,
                'price':this._price,
                'image':'assets/food.jpg'
              };

              widget._addProduct(product);
              Navigator.pushReplacementNamed(context, '/products');
              
              //pass data to main dart
              //widget._addProduct()
            },
            color: Theme.of(context).accentColor,
          )
        ],
        
      
      )
    );
  } 
  
}

