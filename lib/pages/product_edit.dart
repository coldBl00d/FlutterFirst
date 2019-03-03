import 'package:flutter/material.dart';
import '../widgets/helpers/ensure-visible.dart';
import '../models/Product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

class EditProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditProductState();
  }
}

class EditProductState extends State<EditProduct> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _descFocusNode = FocusNode();
  final Map<String, dynamic> _formData = {
    'title': null,
    'price': null,
    'desc': null,
    'image': 'assets/food.jpg',
  };
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget _buildTitleTF(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: this._titleFocusNode,
      child: TextFormField(
        focusNode: this._titleFocusNode,
        initialValue: product != null ? product.title : "",
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
      ),
    );
  }

  Widget _buildPriceTF(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        initialValue: product != null ? product.price.toString() : "",
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
          } else if (!RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$')
              .hasMatch(value)) {
            return "Price needs to be a number";
          }
        },
      ),
    );
  }

  Widget _buildDescTF(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _descFocusNode,
      child: TextFormField(
        focusNode: _descFocusNode,
        initialValue: product != null ? product.desc : "",
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
      ),
    );
    //onChanged: (String i) => this._desc = i);
  }

  void _submitForm(Function addProduct, Function updateProduct,
      Product selectedProduct, Function setSelectedProduct) {
    bool validated = formKey.currentState.validate();
    if (!validated) return;
    formKey.currentState
        .save(); //this will call onsave of all child of the forum.
    if (selectedProduct == null)
      addProduct(
        title: this._formData['title'],
        price: this._formData['price'],
        desc: this._formData['desc'],
      ).then(
        (bool success) {
          if (success) {
            Navigator.pushReplacementNamed(context, '/products')
                .then((_) => setSelectedProduct(null));
          } else {
            showDialog(
              //! Context is always stored in the state as a property which can be accessed anywhere within the state
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Something went wrong"),
                    content: Text("Please try again"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Okay"),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  );
                });
          }
        },
      );
    else
      updateProduct(
              title: this._formData['title'],
              price: this._formData['price'],
              desc: this._formData['desc'],
              unsetSelectedAfterUpdate: false)
          .then(
        (_) {
          Navigator.pushReplacementNamed(context, '/products')
              .then((_) => setSelectedProduct(null));
        },
      );
    ;

    //Navigator.pushReplacementNamed(context, '/products')
    //   .then((_) => setSelectedProduct(null));

    //pass data to main dart
    //widget._addProduct()
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return RaisedButton(
            textColor: Colors.white70,
            child: Text(
              "Save",
            ),
            onPressed: () => this._submitForm(
                model.addProduct,
                model.updateProduct,
                model.getSelectedProduct(),
                model.setSelectedProductId),
          );
        }
      },
    );
  }

  Widget _buildMainContent(double _targetPadding, double _targetWidth,
      BuildContext context, MainModel model) {
    return GestureDetector(
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
              this._buildTitleTF(model.getSelectedProduct()),
              this._buildPriceTF(model.getSelectedProduct()),
              this._buildDescTF(model.getSelectedProduct()),
              SizedBox(
                height: 20.0,
              ),
              _buildSubmitButton(),
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
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;
    final double _targetWidth = _deviceWidth > 550 ? 500 : _deviceWidth * 0.95;
    final double _targetPadding = _deviceWidth - _targetWidth;

    // TODO: implement buildll;
    //used as a tab previously thus doesnt contain a scaffold
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget mainContent =
            _buildMainContent(_targetPadding, _targetWidth, context, model);
        return model.selectedProductId == null
            ? mainContent
            : Scaffold(
                appBar: AppBar(
                  title: Text("Edit Product"),
                ),
                body: mainContent,
              );
      },
    );
  }
}
