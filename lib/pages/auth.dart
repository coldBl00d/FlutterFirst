import 'package:flutter/material.dart';
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

  DecorationImage _buildDecorationImage(){
    return DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop)
          );
  }

  Widget _buildEmailTF(){
    return TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String i) {
                    widget._email = i;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Email Id"),
                );
  }

  Widget _buildPasswordTF(){
    return TextField(
                  onChanged: (String i) {
                    widget._password = i;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                  ),
                );
  }

  Widget _buildAcceptSwitch(){
    return SwitchListTile(
                  title: Text("Accept"),
                  value: _accept,
                  onChanged: (bool value) {
                    setState(() {
                      _accept = value;
                    });
                  },
                );
  }

  void submit(){
    print(widget._email);
    print(widget._password);
    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildLoginButton(){
    return RaisedButton(
                  textColor: Colors.white70,
                  child: Text("Login"),
                  onPressed: this.submit
                );
  }

  Widget generateAuthPage(context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double _targetWidth = deviceWidth > 500.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
        appBar: AppBar(
          title: Text("Please enter your credentials"),
        ),
        body: Container(
            decoration: BoxDecoration(image: this._buildDecorationImage()),
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: SingleChildScrollView(
                child:Container(
                  width: _targetWidth,
                  child: Column(
                  children: <Widget>[
                    this._buildEmailTF(),
                    SizedBox(height: 10.0),
                    this._buildPasswordTF(),
                    this._buildAcceptSwitch(),
                    SizedBox(height: 10.0,),
                    this._buildLoginButton()
                  ],
                ),

                ) ))));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return this.generateAuthPage(context);
  }
}
