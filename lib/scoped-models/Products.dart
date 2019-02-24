import 'package:scoped_model/scoped_model.dart';
import '../models/Product.dart';
import 'package:flutter/material.dart';
import './connected-products.dart';

mixin ProductsModel on ConnectedProducts {
  bool _isFavoriteMode = false;

  List<Product> get allProducts {
    return List.from(products);
  }

  List<Product> get displayedProducts {
    if (_isFavoriteMode) {
      return List.from(
          products.where((Product product) => product.isFavorite).toList());
    }
    return List.from(products);
  }

  bool get favoriteMode {
    return this._isFavoriteMode;
  }


  void deleteProduct(int index) {
    this.products.removeAt(index);
    this.selectedProductIndex = null;
  }

  void updateProduct({@required String title,@required String desc,
      @required double price,String image = 'assets/food.jpg',bool isFavorite = false, String userEmail, String userId}) {
    
    Product updatedProduct = Product(title: title, desc: desc, price: price, isFavorite: isFavorite, userEmail: this.authenticatedUser.email, userId: this.authenticatedUser.id);
    this.products[this.selectedProductIndex] = updatedProduct;
    this.selectedProductIndex = null;
  }

  void selectProduct(int index) {
    assert(index <= this.products.length);
    assert(index >= 0);
    assert(this.products != null);
    this.selectedProductIndex = index;
  }

  Product getSelectedProduct() {
    if (this.selectedProductIndex != null) {
      return products[this.selectedProductIndex];
    }
    return null;
  }

  int getProductCount() {
    return this.products.length;
  }

  int getSelectedProductIndex() {
    return this.selectedProductIndex;
  }

  Product getProduct(int index) {
    if (index <= this.products.length) {
      return this.products[index];
    } else {
      return null;
    }
  }

  void toggleProductFavorite(int index) {
    this.selectProduct(index);
    Product selectedProduct = this.getSelectedProduct();
    bool newIsFavoriteStatus =
        !(this.products[this.selectedProductIndex].isFavorite);
    this.updateProduct(title: selectedProduct.title,
        price: selectedProduct.price,
        desc: selectedProduct.desc,
        userEmail: authenticatedUser.email,
        userId: authenticatedUser.password,
        isFavorite: newIsFavoriteStatus);
    notifyListeners();
  }

  void toggleDisplayMode() {
    this._isFavoriteMode = !this._isFavoriteMode;
    this.selectedProductIndex = null;
    notifyListeners();
  }
}
