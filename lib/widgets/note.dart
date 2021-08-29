import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/screens/note_detail.dart';

class Note extends StatefulWidget {
  final NoteModel note;
  const Note({Key? key, required this.note}) : super(key: key);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  late String title;
  late String body;
  late NoteModel note;
  @override
  Widget build(BuildContext context) {
    setState(() {
      note = widget.note;
    });
    return InkWell(
      onTap: () {
        print('tapped item');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NoteDetail(note: note)));
      },
      child: Container(
        color: Colors.amber,
        margin: EdgeInsets.only(bottom: 15.0),
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              note.title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[900],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              note.body,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[900],
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
