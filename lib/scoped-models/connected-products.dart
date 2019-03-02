import 'package:course/models/Product.dart';
import 'package:course/models/user.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

mixin ConnectedProductsModel on Model {
  final List<Product> _products = [];
  User _authenticatedUser;
  int _selectedProductIndex;
  final String _firebaseUrl = 'https://flutter-products-69c0b.firebaseio.com';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<Null> addProduct(
      {@required String title,
      @required String desc,
      @required double price,
      String image = 'https://moneyinc.com/wp-content/uploads/2017/07/Chocolate.jpg',
      bool isFavorite = false}) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'desc': desc,
      'price': price,
      'image': 'https://moneyinc.com/wp-content/uploads/2017/07/Chocolate.jpg',
      'userEmail': this._authenticatedUser.email,
      'userId': this._authenticatedUser.id
    };

    return http
        .post(
      this._firebaseUrl + '/products.json',
      body: convert.json.encode(productData),
    )
        .then(
      (http.Response res) {
        if (res.statusCode == 200) {
          _isLoading = false;
          Map<String, dynamic> resBody = convert.json.decode(res.body);
          Product newProduct = Product(
              id: resBody['name'],
              title: title,
              desc: desc,
              price: price,
              isFavorite: isFavorite,
              userEmail: this._authenticatedUser.email,
              userId: this._authenticatedUser.id,
              image:image);

          this._products.add(newProduct);
          this._selectedProductIndex = null;
          _isLoading = false;
          notifyListeners();
        }
      },
    );
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

  void setSelectedIndex(int index) {
    this._selectedProductIndex = index;
    print("Product selection cleared");
  }

  void deleteProduct(int index) {
    this._products.removeAt(index);
    this._selectedProductIndex = null;
  }

  void updateProduct(
      {@required String title,
      @required String desc,
      @required double price,
      String image = 'assets/food.jpg',
      bool isFavorite = false,
      String userEmail,
      String userId}) {
    Product updatedProduct = Product(
        title: title,
        desc: desc,
        price: price,
        isFavorite: isFavorite,
        userEmail: this._authenticatedUser.email,
        userId: this._authenticatedUser.id);
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
    this.updateProduct(
        title: selectedProduct.title,
        price: selectedProduct.price,
        desc: selectedProduct.desc,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.password,
        isFavorite: newIsFavoriteStatus, 
        image: selectedProduct.image);
    notifyListeners();
  }

  void toggleDisplayMode() {
    this._isFavoriteMode = !this._isFavoriteMode;
    this._selectedProductIndex = null;
    notifyListeners();
  }

  void fetchProducts() {
    _isLoading = true;
    notifyListeners();
    _products.clear();
    http.get(_firebaseUrl + '/products.json').then(
      (http.Response res) {
        print(convert.json.decode(res.body).toString());
        Map<String, dynamic> bodyMap = convert.json.decode(res.body);
        if (bodyMap != null) {
          bodyMap.forEach(
            (String key, dynamic product) {
              Product p = Product(
                id: key,
                title: product['title'],
                desc: product['desc'],
                price: product['price'],
                userEmail: product['userEmail'],
                userId: product['userId'],
                image: product['image'],
              );
              _products.add(p);
            },
          );
        }
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}

mixin UserModel on ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User('jdifhendlci', email, password);
  }
}
