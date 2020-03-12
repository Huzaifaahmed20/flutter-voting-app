import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/MovieModel.dart';
import './ConfirmationDialog.dart';

Widget buildListTile(BuildContext context, DocumentSnapshot document) {
  final movieRef = ScopedModel.of<MovieModel>(context);

  return Dismissible(
    direction: DismissDirection.endToStart,
    key: ValueKey(document),
    background: Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      child: Icon(
        Icons.delete,
        size: 25,
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(right: 20),
    ),
    confirmDismiss: (_) {
      return showConfirmationDialog(context);
    },
    onDismissed: (_) => movieRef.deleteMovie(document.documentID),
    child: InkWell(
      onTap: () => movieRef.updateCollection(document),
      child: ListTile(
          leading: Text(
            '${document['name']}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          trailing: CircleAvatar(
            child: Text(
              '${document['votes']}',
              style: TextStyle(fontSize: 20),
            ),
          )),
    ),
  );
}
