import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';
import '../models/auth.dart';

class AuthPage extends StatefulWidget {
  final Map<String, dynamic> _creds = {
    'email': null,
    'password': null,
    'agreed': true
  };

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> authKey = GlobalKey<FormState>();
  AuthMode _curAuthMode = AuthMode.Login;

  DecorationImage _buildDecorationImage() {
    return DecorationImage(
        image: AssetImage('assets/background.jpg'),
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop));
  }

  Widget _buildEmailTF() {
    return TextFormField(
      initialValue: 'akhil.raj@ork.com',
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

  Widget _buildConfirmPasswordTF() {
    return TextFormField(
      ////initialValue: 'jdjdjdjdjdjdjdjdjdj',
      onSaved: (String i) {
        widget._creds['password'] = i;
      },
      /*validator: (String password) {
        if(_passwordController.text !=password){
          return "Password mismatch";
        }
      },*/
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildPasswordTF() {
    return TextFormField(
      ////initialValue: 'jdjdjdjdjdjdjdjdjdj',
      controller: _passwordController,
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

  void submit(Function authenticate) async {
    print(widget._creds['agreed']);
    if (!this.authKey.currentState.validate() || !(widget._creds['agreed']))
      return;
    this.authKey.currentState.save();

    Map<String, dynamic> res;

    res = await authenticate(
        widget._creds['email'], widget._creds['password'], authMode: _curAuthMode);

    if (res['success'] == true) {
      //Navigator.pushReplacementNamed(context, '/');
    } else {
      // * context we get from the state class as this is used within that.
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("An Error Occured"),
              content: Text(res['message']),
              actions: <Widget>[
                FlatButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // * pops the dialog off the view.
                  },
                ),
              ],
            );
          });
    }
  }

  Widget _buildLoginButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? CircularProgressIndicator()
            : RaisedButton(
                textColor: Colors.white70,
                child: Text(
                    "${_curAuthMode == AuthMode.Login ? 'Login' : 'SignUp'}"),
                onPressed: () => this.submit(model.authenticate),
              );
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
                    SizedBox(height: 10.0),
                    _curAuthMode == AuthMode.SignUp
                        ? this._buildConfirmPasswordTF()
                        : Container(),
                    this._buildAcceptSwitch(),
                    SizedBox(
                      height: 10.0,
                    ),
                    FlatButton(
                      child: Text(
                          "${_curAuthMode == AuthMode.Login ? 'Sign Up' : 'Login'}"),
                      onPressed: switchAuthMode,
                    ),
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

  void switchAuthMode() {
    setState(() {
      if (_curAuthMode == AuthMode.Login) {
        _curAuthMode = AuthMode.SignUp;
      } else {
        _curAuthMode = AuthMode.Login;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return this.generateAuthPage(context);
  }
}
