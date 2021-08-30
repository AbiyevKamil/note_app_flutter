import 'package:flutter/material.dart';
import 'package:note_app/database/database_provider.dart';
import 'package:note_app/models/note_model.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  late String title;
  late String body;
  late DateTime date;

  addNote(NoteModel note) async {
    await DatabaseProvider.db.addNewNote(note);
    print('Added successfully');
  }

  @override
  Widget build(BuildContext context) {
    //  homescreen.dart -dan bize gleen datani gotururuk ama tipi Objectdi deye biz bunu Functiona cast edirik
    //  javada cast etme bu curdu -> (Function) ....arguments,
    //  ama dartda as Function edirik c#-a oxsuyur :)
    //  Not: men gonderdiyim datanin kankret Function oldugunu bildiyim ucun Functiona cast edirem
    //  eger bashga sey gonderseydim Functiona cast edenmezdim etseydim exception atasiydi

    Function stateChanger =
        ModalRoute.of(context)?.settings.arguments as Function;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Note',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 22.0,
          ),
        ),
        leading: BackButton(
          color: Colors.amber,
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
        color: Colors.grey[900],
        child: Column(
          children: [
            TextField(
              controller: titleController,
              maxLines: 1,
              style: TextStyle(
                color: Colors.amber,
                fontSize: 22,
              ),
              cursorColor: Colors.amber,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
                hintStyle: TextStyle(
                  color: Colors.amber,
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            TextField(
              controller: bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(
                color: Colors.amber,
                fontSize: 16,
              ),
              cursorColor: Colors.amber,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Add your note content here",
                hintStyle: TextStyle(
                  color: Colors.amber,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.amber,
          onPressed: () async {
            if (titleController.text.isNotEmpty &&
                bodyController.text.isNotEmpty) {
              setState(() {
                title = titleController.text;
                body = bodyController.text;
                date = DateTime.now();
              });
              NoteModel note = NoteModel(title: title, body: body, date: date);
              await addNote(note);
              // Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);

              // homescreen.dart-daki stateChanger parametr olaraq funksiya goturur
              // ve stateni deyisende o funksiyani ise salir indi biz parametr olaraq lambda/arrow/anonymous funksiya
              // gonderirik
              stateChanger(() {
                Navigator.pop(context);
              });
            }
          },
          label: Text(
            "Save note",
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 16,
            ),
          )),
    );
  }
}
