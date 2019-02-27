import 'package:course/models/Product.dart';
import 'package:course/models/user.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
 

mixin ConnectedProductsModel on Model {

  final List<Product> _products = [];
  User _authenticatedUser; 
  int _selectedProductIndex;

   void addProduct({@required String title,@required String desc,
      @required double price,String image = 'assets/food.jpg',bool isFavorite = false}) {

    
    Product newProduct = Product(title: title, desc: desc, price: price, isFavorite: isFavorite, userEmail: this._authenticatedUser.email, userId: this._authenticatedUser.id);
    this._products.add(newProduct);
    this._selectedProductIndex = null;
  }

} 

mixin ProductsModel on ConnectedProductsModel {
  bool _isFavoriteMode = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_isFavoriteMode) {
      return List.from(
          _products.where((Product product) => product.isFavorite).toList());
    }
    return List.from(_products);
  }

  bool get favoriteMode {
    return this._isFavoriteMode;
  }

  void setSelectedIndex(int index){
    this._selectedProductIndex = index;
    print("Product selection cleared");
  }

  void deleteProduct(int index) {
    this._products.removeAt(index);
    this._selectedProductIndex = null;
  }

  void updateProduct({@required String title,@required String desc,
      @required double price,String image = 'assets/food.jpg',bool isFavorite = false, String userEmail, String userId}) {
    
    Product updatedProduct = Product(title: title, desc: desc, price: price, isFavorite: isFavorite, userEmail: this._authenticatedUser.email, userId: this._authenticatedUser.id);
    this._products[this._selectedProductIndex] = updatedProduct;
    //this._selectedProductIndex = null;
  }

  void selectProduct(int index) {
    assert(index <= this._products.length);
    assert(index >= 0);
    assert(this._products != null);
    this._selectedProductIndex = index;
  }

  Product getSelectedProduct() {
    if (this._selectedProductIndex != null) {
      return _products[this._selectedProductIndex];
    }
    return null;
  }

  int getProductCount() {
    return this._products.length;
  }

  int getSelectedProductIndex() {
    return this._selectedProductIndex;
  }

  Product getProduct(int index) {
    if (index <= this._products.length) {
      return this._products[index];
    } else {
      return null;
    }
  }

  void toggleProductFavorite(int index) {
    this.selectProduct(index);
    Product selectedProduct = this.getSelectedProduct();
    bool newIsFavoriteStatus =
        !(this._products[this._selectedProductIndex].isFavorite);
    this.updateProduct(title: selectedProduct.title,
        price: selectedProduct.price,
        desc: selectedProduct.desc,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.password,
        isFavorite: newIsFavoriteStatus);
    notifyListeners();
  }

  void toggleDisplayMode() {
    this._isFavoriteMode = !this._isFavoriteMode;
    this._selectedProductIndex = null;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProductsModel {

  void login(String email, String password){
    _authenticatedUser = User('jdifhendlci', email, password);
  }

}