import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../stream/index.dart';
import '../builderMethods/BottomModalSheet.dart';
import '../models/ThemeModel.dart';
import '../models/AuthModel.dart';
import '../builderMethods/BuildAppBar.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ScopedModel.of<ThemeChanger>(context);
    final auth = ScopedModel.of<AuthModel>(context);

    return Builder(
      builder: (ctx) => Scaffold(
          drawer: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  color: Colors.teal,
                  height: 200,
                  width: double.infinity,
                ),
                FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  onPressed: () async {
                    await auth.logOut();
                    //close drawer
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.movie),
            label: Text("Add Movies"),
            onPressed: () => showBottomSheetModal(ctx, theme.isDarkMode),
          ),
          appBar: appBarWithThemeChanger(theme, 'Tap to vote for movies'),
          body: CustomStreamBuider()),
    );
  }
}
