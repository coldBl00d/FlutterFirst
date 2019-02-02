import 'package:flutter/material.dart';

class CreateProduct extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CreateProductState();
  }
}

class CreateProductState extends State<CreateProduct>{
  
  String name;
  double price; 
  String desc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildll;
    return Column(
      children: <Widget>[
        TextField(onChanged: (String i){
            // setState(() {
             this.name = i;
            //});
        },),
        TextField(onChanged: (String i){
          this.price = double.parse(i);
        },
          keyboardType: TextInputType.number,
        ),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: 5,
          onChanged: (String i) => this.desc = i
        ),
      ],
    );
  } 
  
}

