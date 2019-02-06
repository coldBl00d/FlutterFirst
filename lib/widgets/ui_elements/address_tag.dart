import 'package:flutter/material.dart';

class AddressTag extends StatelessWidget {

  final String address;

  AddressTag({this.address = "Union Square, San Franscisco"});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
              padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 6.0),
              child: Text(this.address),
              decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(5.0),
            ),);
  }


}