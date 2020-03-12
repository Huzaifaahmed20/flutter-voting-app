import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './models/MovieModel.dart';
import './models/ThemeModel.dart';
import './models/AuthModel.dart';

import './screens/Login.dart';
import './screens/SignUp.dart';
import './screens/Home.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ThemeChanger>(
        model: ThemeChanger(ThemeData(fontFamily: 'CabinRegular', brightness: Brightness.light)),
        child: ScopedModel<AuthModel>(
            model: AuthModel(),
            child: ScopedModel<MovieModel>(
              model: MovieModel(),
              child: MaterialAppWithTheme(),
            )));
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ScopedModel.of<ThemeChanger>(context, rebuildOnChange: true);
    final auth = ScopedModel.of<AuthModel>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      theme: theme.getTheme(),
      home: StreamBuilder(
          stream: auth.isAuth,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                return HomeScreen();
              }
              return LoginScreen();
            }
          }),
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
      },
    );
  }
}
