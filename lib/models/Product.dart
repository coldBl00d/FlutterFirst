import 'package:flutter/material.dart';

class Product {
  String title, desc;
  String image;
  double price;
  bool isFavorite;
  final String userEmail;
  final String userId;
  final String id;

  Product(
      {@required this.id,
      @required this.title,
      @required this.desc,
      @required this.price,
      this.isFavorite = false,
      this.image,
      @required this.userId,
      @required this.userEmail});
}
