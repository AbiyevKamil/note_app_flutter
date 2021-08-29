import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';

class NoteDetail extends StatefulWidget {
  final NoteModel note;
  const NoteDetail({Key? key, required this.note}) : super(key: key);

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  late TextEditingController titleController;
  late TextEditingController bodyController;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    bodyController = TextEditingController(text: widget.note.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
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
        actions: <Widget>[
          TextButton(
            onPressed: () {
              print('tapped');
            },
            style: TextButton.styleFrom(
              primary: Colors.amber,
            ),
            child: Icon(
              Icons.save,
              color: Colors.amber,
            ),
          ),
        ],
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
              TextField(
                controller: bodyController,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 22,
                ),
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Add your note content here",
                  hintStyle: TextStyle(
                    color: Colors.amber,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          )),
      floatingActionButton: TextButton.icon(
        onPressed: () async {
          
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
