import 'package:flutter/material.dart';
import 'package:note_app/database/database_provider.dart';
import 'package:note_app/models/note_model.dart';

class NoteDetail extends StatefulWidget {
  final NoteModel note;
  final Function stateChanger;
  const NoteDetail({Key? key, required this.note, required this.stateChanger})
      : super(key: key);

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  int? id;
  @override
  void initState() {
    super.initState();
    id = widget.note.id;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.note.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note.body,
          style: TextStyle(
            color: Colors.amber,
            fontSize: 22,
          ),
        ),
        leading: BackButton(
          color: Colors.amber,
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            bottom: 5.0,
            top: 10.0,
          ),
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey[900],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Saved at ${widget.note.date.toString().substring(0, 11)} | ${widget.note.date.toString().substring(11, 16)}",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                child: Text(
                  widget.note.title,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 22,
                  ),
                ),
              )
            ],
          )),
      floatingActionButton: TextButton.icon(
        onPressed: () async {
          await DatabaseProvider.db.deleteNote(id!);
          print('deleted');

          // silen kimi movcud ekrani sil (bilinsinki silindi)
          widget.stateChanger(() {
            Navigator.pop(context);
          });
        },
        icon: Icon(
          Icons.delete,
          color: Colors.grey[900],
        ),
        style: TextButton.styleFrom(
          primary: Colors.amber,
          backgroundColor: Colors.amber,
        ),
        label: Text(
          'Delete',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
