import 'package:course/models/Product.dart';
import 'package:course/models/user.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

mixin ConnectedProductsModel on Model {
  final List<Product> _products = [];
  User _authenticatedUser;
  //int _selectedProductIndex;
  final String _firebaseUrl = 'https://flutter-products-69c0b.firebaseio.com';
  bool _isLoading = false;
  String _selectedProductId;

  bool get isLoading => _isLoading;

  String get selectedProductId {
    return _selectedProductId;
  }

  Future<bool> addProduct(
      {@required String title,
      @required String desc,
      @required double price,
      String image =
          'https://moneyinc.com/wp-content/uploads/2017/07/Chocolate.jpg',
      bool isFavorite = false}) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'desc': desc,
      'price': price,
      'image': 'https://moneyinc.com/wp-content/uploads/2017/07/Chocolate.jpg',
      'userEmail': _authenticatedUser == null
          ? "temp@oracle.com"
          : _authenticatedUser.email,
      'userId': _authenticatedUser == null
          ? "kajsdkfjaslkdfj"
          : _authenticatedUser.id,
      'isFavorite': isFavorite
    };

    return http
        .post(
      this._firebaseUrl + '/products.json',
      body: convert.json.encode(productData),
    )
        .then(
      (http.Response res) {
        if (res.statusCode == 200 || res.statusCode == 201) {
          _isLoading = false;
          Map<String, dynamic> resBody = convert.json.decode(res.body);
          Product newProduct = Product(
              id: resBody['name'],
              title: title,
              desc: desc,
              price: price,
              isFavorite: isFavorite,
              userEmail: _authenticatedUser == null
                  ? "temp@oracle.com"
                  : _authenticatedUser.email,
              userId: _authenticatedUser == null
                  ? "kajsdkfjaslkdfj"
                  : _authenticatedUser.id,
              image: image);

          this._products.add(newProduct);
          this._selectedProductId = null;
          _isLoading = false;
          notifyListeners();
          return true;
        }else{
          // * Not successfull 
          _isLoading = false;
          notifyListeners();
          return false;
        }
      },
    ).catchError((error){
      _isLoading = false;
      notifyListeners();
      return false;
    });
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

  void setSelectedProductId(String id) {
    this._selectedProductId = id;
    if (id != null)
      print("Product selection set to " + id.toString());
    else
      debugPrint("Clearing product selection");
  }

  Future<bool> deleteProduct({String id, int index}) {
    print("Delete Product " + id);

    return http
        .delete(_firebaseUrl + '/products/${id}.json')
        .then((http.Response res) {
      if (res.statusCode == 200) {
        index = _products.indexWhere((Product product) {
          return product.id == id;
        });

        if (index != -1) {
          this._products.removeAt(index);
          debugPrint("Deleted product at index "+index.toString());
        }
        _selectedProductId = null;
        notifyListeners();
        return true;
      }
    }).catchError((error){
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> updateProduct(
      {@required String title,
      @required String desc,
      @required double price,
      String image = 'assets/food.jpg',
      bool isFavorite = false,
      String userEmail,
      String userId,
      bool unsetSelectedAfterUpdate=true}) {
    _isLoading = true;
    notifyListeners();

    Product updatedProduct = Product(
      id: this.getSelectedProduct().id, //flaky
      title: title,
      desc: desc,
      price: price,
      isFavorite: isFavorite,
      image: 'https://moneyinc.com/wp-content/uploads/2017/07/Chocolate.jpg',
      userEmail: _authenticatedUser == null
          ? "temp@oracle.com"
          : _authenticatedUser.email,
      userId: _authenticatedUser == null
          ? "kajsdkfjaslkdfj"
          : _authenticatedUser.id,
    );

    Map<String, dynamic> updateData = {
      'title': title,
      'desc': desc,
      'image': 'https://moneyinc.com/wp-content/uploads/2017/07/Chocolate.jpg',
      'price': price,
      'userEmail': _authenticatedUser == null
          ? "temp@oracle.com"
          : _authenticatedUser.email,
      'userId': _authenticatedUser == null
          ? "kajsdkfjaslkdfj"
          : _authenticatedUser.id,
      'isFavorite': isFavorite,
    };

    return http
        .put(_firebaseUrl + '/products/${updatedProduct.id}.json',
            body: convert.json.encode(updateData))
        .then((http.Response res) {
      if (res.statusCode == 200) {
        print("Status is 200 for update");
        final int selectedProductIndex =
            _products.indexWhere((Product product) {
          return product.id == _selectedProductId;
        });
        this._products[selectedProductIndex] = updatedProduct;
      }
      print("Setting isLoading to false by update product");
      _isLoading = false;
      if (unsetSelectedAfterUpdate) {
        debugPrint("Unsetting selected product :" +
            this.selectedProductId.toString() +
            " to null");
        this.setSelectedProductId(null);
      }
      notifyListeners();
    }).catchError((error){
      _isLoading = false;
      notifyListeners();
      return false;
    });
    //this._selectedProductIndex = null;
  }

  

//! Flaky code
  Product getSelectedProduct() {
    return _products.firstWhere((Product product) {
      if (_selectedProductId != null) {
        return product.id == _selectedProductId;
      } else {
        return false;
      }
    }, orElse: () {
      return null;
    });
  }

  int getProductCount() {
    return this._products.length;
  }

  String get selectedProductId {
    return this._selectedProductId;
  }

  Product getProduct({String id, int index}) {
    if (id != null && id.length > 0 && index == null) {
      debugPrint("Getting product for id " + id);
      return _products.firstWhere((Product product) {
        return product.id == id;
      }, orElse: () {
        return null;
      });
    } else if (index != null && id == null) {
      if (index <= _products.length - 1) return _products[index];
    }
    return null;
  }

  void toggleProductFavorite(String id, {bool unsetSelectedProduct}) {
    this.setSelectedProductId(id);
    Product selectedProduct = this.getSelectedProduct();
    bool newIsFavoriteStatus = !(this.getSelectedProduct().isFavorite);
    this.updateProduct(
        title: selectedProduct.title,
        price: selectedProduct.price,
        desc: selectedProduct.desc,
        userEmail: _authenticatedUser == null
            ? "temp@oracle.com"
            : _authenticatedUser.email,
        userId: _authenticatedUser == null
            ? "kajsdkfjaslkdfj"
            : _authenticatedUser.id,
        isFavorite: newIsFavoriteStatus,
        image: selectedProduct.image,
        unsetSelectedAfterUpdate: unsetSelectedProduct);
    notifyListeners();
  }

  void toggleDisplayMode() {
    this._isFavoriteMode = !this._isFavoriteMode;
    this._selectedProductId = null;
    notifyListeners();
  }

  Future<Null> fetchProducts() {
    _isLoading = true;
    print("Setting isloading to true by fetchProduct");
    notifyListeners();
    _products.clear();
    return http.get(_firebaseUrl + '/products.json').then(
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
                isFavorite: product['isFavorite'],
              );
              _products.add(p);
            },
          );
        }
        _isLoading = false;
        notifyListeners();
      },
    )..catchError((error){
      _isLoading = false;
      notifyListeners();
      return null;
    });
  }
}

mixin UserModel on ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User('jdifhendlci', email, password);
  }
}
