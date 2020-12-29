import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_appseccccccccccccccccc/auth_provider.dart';
import 'package:flutter_appseccccccccccccccccc/product_screen.dart';

import 'package:provider/provider.dart';
import 'Sing_up.dart';


// enum AuthMode { SignUp, Login }

class AuthScreen extends StatelessWidget {
  //static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
 @override


  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };




  final GlobalKey<FormState> _formKey = GlobalKey();

  //AuthMode _authMode = AuthMode.Login;

  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErorrDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("An error Occurred!"),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(ctx).pop();
              })
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_isValid) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<AuthProvider>(context, listen: false).logIn(
            _authData['email'].trim(),
            _authData['password'].trim(),
        );
        await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => ProductScreen()));

      } catch (e) {
        var errorMessage = "فشل الدخول";
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          errorMessage = "هذا الاميل غير موجود اعد التسجيل";
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          errorMessage = "برجاء ادخال كلمه سر صحيحه";
        }
        _showErorrDialog(errorMessage);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        constraints: BoxConstraints(minHeight: 260),
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child: Text('LOGIN'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text("SIGN UP INSTEAD"),
                  onPressed: //_switchAuthMode
                      () => Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => SignUp())),
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
