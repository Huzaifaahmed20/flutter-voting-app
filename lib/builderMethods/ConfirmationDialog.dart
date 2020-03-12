import 'package:flutter/material.dart';

Future<bool> showConfirmationDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You want to delete this?'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => Navigator.of(ctx).pop(false),
              ),
              FlatButton(
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => Navigator.of(ctx).pop(true),
              ),
            ],
          ));
}
