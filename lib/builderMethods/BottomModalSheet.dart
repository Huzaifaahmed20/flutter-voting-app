import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/MovieModel.dart';

Future<void> showBottomSheetModal(
  BuildContext ctx,
  bool isDarkMode
) {
  final movieRef = ScopedModel.of<MovieModel>(ctx);
  final movieNameController = TextEditingController();

  return showModalBottomSheet(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      context: ctx,
      builder: (_) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  controller: movieNameController,
                  decoration: InputDecoration(
                    labelText: 'Movie Name',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                OutlineButton(
                  child: Text(
                    'Add',
                  ),
                  onPressed: () {
                    movieRef.addMovie(movieNameController.text);
                    Navigator.of(ctx).pop();
                  },
                  borderSide: BorderSide(color: Colors.purple, width: 2),
                )
              ],
            ),
          ),
        );
      });
}
