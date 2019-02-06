import 'package:flutter/material.dart';
import '../product_manager.dart';
import '../pages/products.dart';

class AuthPage extends StatefulWidget {
  String _email;
  String _password;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  bool _accept = false;

  Widget generateAuthPage(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Please enter your credentials"),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.dstATop))),
            padding: EdgeInsets.all(10.0),
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String i) {
                    widget._email = i;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Email Id"),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  onChanged: (String i) {
                    widget._password = i;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SwitchListTile(
                  title: Text("Accept"),
                  value: _accept,
                  onChanged: (bool value) {
                    setState(() {
                      _accept = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white70,
                  child: Text("Login"),
                  onPressed: () {
                    print(widget._email);
                    print(widget._password);
                    Navigator.pushReplacementNamed(context, '/products');
                  },
                )
              ],
            )))));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return this.generateAuthPage(context);
  }
}
