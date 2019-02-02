import 'package:flutter/material.dart';

class CreateProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement buildll;
    return Center(
      child:RaisedButton(
        child: Text("Create Product"),
        onPressed: (){
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context){
              return Center(child: Text("Hello there"),);
            });
        },));
  }
}