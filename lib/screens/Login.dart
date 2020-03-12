import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_fire/models/AuthModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../builderMethods/BuildAppBar.dart';
import '../models/ThemeModel.dart';
import './SignUp.dart';

class LoginScreen extends StatelessWidget {
  static final routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final theme = ScopedModel.of<ThemeChanger>(context);
    final auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    final TextEditingController _emailCOntroller = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      appBar: appBarWithThemeChanger(theme, 'Login'),
      body: Container(
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 25),
              child: Text(
                'Come back',
                style: TextStyle(fontSize: 35, color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: _emailCOntroller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(labelText: 'Password'),
                controller: _passwordController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Align(
                alignment: Alignment.center,
                child: FlatButton(
                  padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                  child: auth.loading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      : Text(
                          'Let me in',
                          style: TextStyle(fontSize: 20),
                        ),
                  onPressed: () async {
                    auth.startLoader();
                    await auth.handleLogin(_emailCOntroller.text, _passwordController.text);
                    auth.stopLoader();
                  },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  icon: Icon(
                    FontAwesomeIcons.facebookF,
                    size: 20,
                  ),
                  color: Color(0xFF3b5998),
                  textColor: Colors.white,
                  label: Text(
                    'Facebook',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 20,
                ),
                FlatButton.icon(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  icon: Icon(
                    FontAwesomeIcons.google,
                    size: 20,
                  ),
                  color: Colors.red,
                  textColor: Colors.white,
                  label: Text(
                    'Google',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () async {
                    await auth.handleGoogleSignup();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Dont have an account? ',
                  children: <TextSpan>[
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context).pushNamed(SignUpScreen.routeName),
                        text: 'Sign Up',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
