import 'package:flutter/material.dart';

class Product {
  final String title, desc;
  final String image;
  final double price;
  final bool isFavorite;
  final String userEmail; 
  final String userId;

  Product({@required this.title, @required this.desc, @required this.price, this.isFavorite = false, this.image='assets/food.jpg', @required this.userId, @required this.userEmail});
}
