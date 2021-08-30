import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/screens/note_detail.dart';

class Note extends StatefulWidget {
  final NoteModel note;
  const Note({Key? key, required this.note, required this.stateChanger})
      : super(key: key);
  final Function stateChanger;

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  late String title;
  late String body;

  // late NoteModel note;

  // Note classindaki  NoteModel nota  access etmek ucun widget.note elemeyin besdi
  // yox eger deyirsenki men isdeyirem mutleq State-in icinde olsun onda buildin icinde setState
  // elemekdense  initState metodunu islet, initState ilk defe state yuklenende ishe dushen metoddu,
  // burda sen ilk defe yuklenende initialize olunmasi lazim olan modelleri initialize edirsen, meselen database kimi

  // @override
  // void initState() {
  //   super.initState();
  //   this.note = widget.note;
  // }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   note = widget.note;
    // });

    return InkWell(
      onTap: () async {
        print('tapped item');

        // demeli bu navigatorlarin metodlari eslinde Featuredi,(jsdaki Promise), sen bundan geri deyer gozluye bilersen,
        //demeli appde esas problem oduki note silinen kimi ana ekranda deyisiklik olmur yeni silinmemis kimi olur
        // halbuki hot reload eliyende gorurukki eslinde silinib ama state deyisilmeyib, indi biz burda deyer gozduyeciyik
        // eger true gelibse demeli silmisik bu zaman stateni deyiseciyik yox eger normal yolla geri qaytarmisiqsa
        //demeli false gelecek onda deymiyeciyik

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoteDetail(
                    note: widget.note, stateChanger: widget.stateChanger)));

        // if (isDeleted) {
        //   setState(() {});
        // }
      },

      // hazir Card ile de yazmaq olardi ama custom yazanda daha cox  oyrenirsen, ela!
      child: Container(
        color: Colors.amber,
        margin: EdgeInsets.only(bottom: 15.0),
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.note.title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[900],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              widget.note.body,
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
