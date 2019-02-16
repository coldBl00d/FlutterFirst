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

class CreateProductState extends State<CreateProduct> {
  String _name;
  double _price;
  String _desc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); 

  Widget _buildTitleTF() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Title',
        //icon: Icon(Icons.edit)
      ),
      onSaved: (String i) => this._name = i,
      // onChanged: (String i) {
      //   // setState(() {
      //   this._name = i;
      //   //});
      // },
      validator: (String value) {
        if(value.isEmpty){
          return "Title is required";
        }
      },
    );
  }

  Widget _buildPriceTF() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Price',
        //icon: Icon(Icons.edit)
      ),
      onSaved: (String i) => this._price = double.parse(i),
      // onChanged: (String i) {
      //   this._price = double.parse(i);
      // },
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildDescTF() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: 'Description',
          //icon: Icon(Icons.edit)
        ),
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        onSaved: (String i) => this._desc = i);
        //onChanged: (String i) => this._desc = i);
  }

  void _submitForm() {
    bool validated = formKey.currentState.validate();
    if(!validated) return;
    formKey.currentState.save(); //this will call onsave of all child of the forum. 
    final Map<String, dynamic> product = {
      'title': this._name,
      'desc': this._desc,
      'price': this._price,
      'image': 'assets/food.jpg'
    };

    widget._addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');

    //pass data to main dart
    //widget._addProduct()
  }

  @override
  Widget build(BuildContext context) {

    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _targetWidth = _deviceWidth > 550 ? 500 : _deviceWidth * 0.95;
    final double _targetPadding = _deviceWidth - _targetWidth;
    
    // TODO: implement buildll;
    return Container(
        width: _targetWidth,
        margin: EdgeInsets.all(20.0),
        child:Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: _targetPadding/2),
            children: <Widget>[
              this._buildTitleTF(),
              this._buildPriceTF(),
              this._buildDescTF(),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                textColor: Colors.white70,
                child: Text(
                  "Save",
                ),
                onPressed: this._submitForm,
              )
              /*GestureDetector(
                onTap: _submitForm,
                child: Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(5.0),
                  child: Text("My Button"),
                )
              )*/
            ],
        ),),);
  }
}
