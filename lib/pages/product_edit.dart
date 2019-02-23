import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;

  EditProduct({this.addProduct, this.product, this.updateProduct});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditProductState();
  }
}

class EditProductState extends State<EditProduct> {
  String _name;
  double _price;
  String _desc;
  final Map<String, dynamic> _formData = {
    'title': null,
    'price': null,
    'desc': null,
    'image': 'assets/food.jpg',
  };
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget _buildTitleTF() {
    return TextFormField(
      initialValue: widget.product != null ? widget.product['title'] : "",
      decoration: InputDecoration(
        labelText: 'Title',
        //icon: Icon(Icons.edit)
      ),
      onSaved: (String i) => this._formData['title'] = i,
      // onChanged: (String i) {
      //   // setState(() {
      //   this._name = i;
      //   //});
      // },
      validator: (String value) {
        if (value.isEmpty) {
          return "Title is required";
        } else if (value.length < 5) {
          return "Value needs to be atleast 5 characters";
        }
      },
    );
  }

  Widget _buildPriceTF() {
    return TextFormField(
      initialValue:
          widget.product != null ? widget.product['price'].toString() : "",
      decoration: InputDecoration(
        labelText: 'Price',
        //icon: Icon(Icons.edit)
      ),
      onSaved: (String i) => this._formData['price'] =
          double.parse(i.replaceFirst(RegExp(r','), '.')),
      // onChanged: (String i) {
      //   this._price = double.parse(i);
      // },
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Price is required";
        } else if (!RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value)) {
          return "Price needs to be a number";
        }
      },
    );
  }

  Widget _buildDescTF() {
    return TextFormField(
      initialValue: widget.product != null ? widget.product['desc'] : "",
      decoration: InputDecoration(
        labelText: 'Description',
        //icon: Icon(Icons.edit)
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      onSaved: (String i) => this._formData['desc'] = i,
      validator: (String value) {
        if (value.isEmpty) {
          return "Description is required";
        } else if (value.length < 10) {
          return "Description needs to be atleast 10 characters";
        }
      },
    );
    //onChanged: (String i) => this._desc = i);
  }

  void _submitForm() {
    bool validated = formKey.currentState.validate();
    if (!validated) return;
    formKey.currentState
        .save(); //this will call onsave of all child of the forum.
    widget.addProduct(this._formData);
    Navigator.pushReplacementNamed(context, '/products');

    //pass data to main dart
    //widget._addProduct()
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _targetWidth = _deviceWidth > 550 ? 500 : _deviceWidth * 0.95;
    final double _targetPadding = _deviceWidth - _targetWidth;
    final Widget mainContent = GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: _targetWidth,
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: _targetPadding / 2),
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
          ),
        ),
      ),
    );

    // TODO: implement buildll;
    //used as a tab previously thus doesnt contain a scaffold
    return widget.product == null
        ? mainContent
        : Scaffold(
            appBar: AppBar(
              title: Text("Edit Product"),
            ),
            body: mainContent,
          );
  }
}
