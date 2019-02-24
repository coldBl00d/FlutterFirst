import 'package:flutter/material.dart';

class Product {
  final String title, desc;
  final String image = 'assets/food.jpg';
  final double price;
  final bool isFavorite;

  Product({@required this.title, @required this.desc, @required this.price, this.isFavorite = false});
}
