import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../builderMethods/BuildAppBar.dart';
import '../models/ThemeModel.dart';
import '../models/AuthModel.dart';
import './Home.dart';

class SignUpScreen extends StatefulWidget {
  static final routeName = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static GlobalKey<FormState> _form = new GlobalKey<FormState>();
  bool _isObsecureText = true;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = ScopedModel.of<ThemeChanger>(context);
    final user = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);

    void _handleSignUp() async {
      user.startLoader();
      final isValid = _form.currentState.validate();
      if (!isValid) {
        user.stopLoader();
        return;
      }
      try {
        await user.handleSignUp(
            _nameController.text, _emailController.text, _passwordController.text);
        user.stopLoader();
        Navigator.pushNamed(context, HomeScreen.routeName);
      } catch (error) {
        user.stopLoader();
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Invalid'),
                  content: Text("${error.message}"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () => Navigator.of(ctx).pop(),
                    )
                  ],
                ));
        return;
      }
    }

    return Scaffold(
      appBar: appBarWithThemeChanger(theme, 'Sign Up'),
      body: Container(
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 25),
                child: Text(
                  'Register In',
                  style: TextStyle(fontSize: 35, color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Name cannot be empty';
                    }
                    return null;
                  },
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email cannot be empty';
                    }

                    return null;
                  },
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _isObsecureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: _isObsecureText
                          ? Icon(FontAwesomeIcons.eyeSlash)
                          : Icon(FontAwesomeIcons.eye),
                      onPressed: () {
                        setState(() {
                          _isObsecureText = !_isObsecureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password cannot be empty';
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                    padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                    child: user.loading
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : Text(
                            'Register In',
                            style: TextStyle(fontSize: 20),
                          ),
                    onPressed: _handleSignUp,
                    color: Colors.green,
                    textColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Or log in via',
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     FlatButton.icon(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 40, vertical: 15),
              //       icon: Icon(
              //         FontAwesomeIcons.facebookF,
              //         size: 20,
              //       ),
              //       color: Color(0xFF3b5998),
              //       textColor: Colors.white,
              //       label: Text(
              //         'Facebook',
              //         style: TextStyle(fontSize: 15),
              //       ),
              //       onPressed: () {},
              //     ),
              //     SizedBox(
              //       width: 20,
              //     ),
              //     FlatButton.icon(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 40, vertical: 15),
              //       icon: Icon(
              //         FontAwesomeIcons.google,
              //         size: 20,
              //       ),
              //       color: Colors.red,
              //       textColor: Colors.white,
              //       label: Text(
              //         'Google',
              //         style: TextStyle(
              //           fontSize: 15,
              //         ),
              //       ),
              //       onPressed: () => user.handleGoogleSignup(),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
