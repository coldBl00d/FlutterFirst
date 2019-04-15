import 'package:flutter/material.dart';

import '../widgets/ui_elements/logout_list_tile.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text("Choose"),
        ),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text("All Products"),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        LogoutListTile(),
      ],
    );
  }
}