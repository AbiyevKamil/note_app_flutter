import 'package:flutter/material.dart';
import 'package:note_app/database/database_provider.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/widgets/note.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<NoteModel>> getNotes() async {
    List<NoteModel> notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Note App',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 22.0,
          ),
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: FutureBuilder(
        future: getNotes(),
        builder:
            (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[900],
                child: Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                    height: 60,
                    width: 60,
                  ),
                ),
              );
            case ConnectionState.done:
              if (snapshot.data!.isNotEmpty)
                return Container(
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 10.0,
                    bottom: 5.0,
                  ),
                  color: Colors.grey[900],
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Note(
                        note: snapshot.data![index],
                      );
                    },
                  ),
                );
              else
                return Container(
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 10.0,
                    bottom: 5.0,
                  ),
                  color: Colors.grey[900],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.stacked_bar_chart_sharp,
                        color: Colors.amber,
                        size: 80.0,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        "You don't have note.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 2.0,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                );
            default:
              return Container(
                padding: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  top: 10.0,
                  bottom: 5.0,
                ),
                color: Colors.grey[900],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.stacked_bar_chart_sharp,
                      color: Colors.amber,
                      size: 80.0,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "You don't have note.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.pushNamed(context, 'addNote');
        },
        child: Icon(
          Icons.note_add,
          color: Colors.grey[900],
          size: 30.0,
        ),
      ),
    );
  }
}

// FloatingActionButton(
//               onPressed: () {},
//               child: Icon(Icons.note_add),
//             ),



            