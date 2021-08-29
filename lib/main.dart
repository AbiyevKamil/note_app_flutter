import 'package:flutter/material.dart';
import 'package:note_app/screens/add_note.dart';
import 'package:note_app/screens/homescreen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      'addNote': (context) => AddNote(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
