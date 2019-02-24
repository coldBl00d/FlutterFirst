import 'package:flutter/material.dart';
import '../pages/products.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

class AuthPage extends StatefulWidget {
  final Map<String, dynamic> _creds = {
    'email': null,
    'password': null,
    'agreed': false
  };

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> authKey = GlobalKey<FormState>();

  DecorationImage _buildDecorationImage() {
    return DecorationImage(
        image: AssetImage('assets/background.jpg'),
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop));
  }

  Widget _buildEmailTF() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (String email) {
        bool validated = true;
        //validated &= (!email.isEmpty);
        validated &= RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(email);
        if (!validated) {
          return "Ops this doesnt looks like an email address";
        }
      },
      onSaved: (String i) {
        widget._creds['email'] = i;
      },
      decoration: InputDecoration(
          filled: true, fillColor: Colors.white, labelText: "Email Id"),
    );
  }

  Widget _buildPasswordTF() {
    return TextFormField(
      onSaved: (String i) {
        widget._creds['password'] = i;
      },
      validator: (String password) {
        bool validated = true;
        validated &= (!password.isEmpty);
        validated &= (password.length > 5);
        print("Password validation " + validated.toString());
        if (!validated) {
          return "Password should be more than 5 characters long";
        }
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      title: Text("Accept"),
      value: widget._creds['agreed'],
      onChanged: (bool value) {
        setState(() {
          widget._creds['agreed'] = value;
        });
      },
    );
  }

  void submit() {
    print(widget._creds['agreed']);
    if (!this.authKey.currentState.validate() || !(widget._creds['agreed']))
      return;
    this.authKey.currentState.save();
    print(widget._creds['email']);
    print(widget._creds['password']);

    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildLoginButton() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
            textColor: Colors.white70,
            child: Text("Login"),
            onPressed: this.submit);
      },
    );
  }

  Widget generateAuthPage(context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double _targetWidth =
        deviceWidth > 500.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(
        title: Text("Please enter your credentials"),
      ),
      body: Form(
        key: authKey,
        child: Container(
          decoration: BoxDecoration(image: this._buildDecorationImage()),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: _targetWidth,
                child: Column(
                  children: <Widget>[
                    this._buildEmailTF(),
                    SizedBox(height: 10.0),
                    this._buildPasswordTF(),
                    this._buildAcceptSwitch(),
                    SizedBox(
                      height: 10.0,
                    ),
                    this._buildLoginButton()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return this.generateAuthPage(context);
  }
}
