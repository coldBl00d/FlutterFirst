import 'package:course/models/Product.dart';
import 'package:course/models/user.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
 

mixin ConnectedProducts on Model {

  final List<Product> products = [];
  User authenticatedUser; 
  int selectedProductIndex;

   void addProduct({@required String title,@required String desc,
      @required double price,String image = 'assets/food.jpg',bool isFavorite = false}) {

    
    Product newProduct = Product(title: title, desc: desc, price: price, isFavorite: isFavorite, userEmail: this.authenticatedUser.email, userId: this.authenticatedUser.id);
    this.products.add(newProduct);
    this.selectedProductIndex = null;
  }

} 