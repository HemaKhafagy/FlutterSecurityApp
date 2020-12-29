
import 'package:flutter/material.dart';
import 'package:flutter_appseccccccccccccccccc/add_new_user.dart';
import 'package:provider/provider.dart';



import 'auth_screen.dart';





class SignUp extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
                     //flex: deviceSize.width > 600 ? 2 : 1,
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
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  var _isLoading = false;
  bool pass = true;
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();





  void _showErorrDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(
            title: Text("An error Occurred!"),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                  child: Text("Ok"),
                  onPressed: (){
                    Navigator.of(ctx).pop();
                  }
              )
            ],
          ),
    );
  }

  Future <void> _submit() async{
    final isValid=_formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<AddNewUser>(context, listen: false)
            .signUp(
          email.text.trim(),
          password.text.trim(),
          name.text.trim(),
        );
        await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => AuthScreen()));
      } catch (e) {
        print(e);
        var errorMessage = "فشل التسجيل";
        if (name.text.isEmpty ||
            email.text.isEmpty ||
            password.text.isEmpty ) {
          errorMessage = "برجاء ادخال جميع الحقول";
        } else if (e.toString().contains('FormatException')) {
          errorMessage = "فشل التسجيل(تاكد من ادخال بيانات صحيحه)";
        }
        // else if (e.code == 'weak-password') {
        //   errorMessage = 'Password is too short!';
        // }
        // else if (e.code == 'email-already-in-use') {
        //   errorMessage =
        //   'The account already exists for that email.';
        // }
        _showErorrDialog(errorMessage);
      }
      //setState(() {
        _isLoading = false;
      //});
    }
  }

  @override
  Widget build(BuildContext context) {

    // final deviceSize = MediaQuery
    //     .of(context)
    //     .size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        constraints:
        BoxConstraints(minHeight: 260),
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(25)),
                      hintText: "الاسم الاول",
                      hintStyle: TextStyle(fontSize: 10),
                    ),
                    controller: name,
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: TextFormField(
                    // textAlign: TextAlign.right,
                    // textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(width: 2)),
                      hintText: "البريد الالكترونى",
                      hintStyle: TextStyle(fontSize: 10),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                        //_showErorrDialog('Invalid email!');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                    controller: email,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    obscureText: pass,
                    controller: password,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(width: 2)),
                        hintText: "انشاء كلمه مرور",
                        hintStyle: TextStyle(fontSize: 10),
                        prefixIcon: IconButton(
                            icon: Icon(
                                pass ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                pass = !pass;
                              });
                            })),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                       // _showErorrDialog('Password is too short!');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Consumer<AddNewUser>(
                //   builder: (context, value, _) =>
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  FlatButton(
                    color: Colors.amber,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    textColor: Colors.white,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      _submit();
                    },
                  ),
                //),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





