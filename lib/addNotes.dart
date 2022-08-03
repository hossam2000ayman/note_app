import 'package:flutter/material.dart';
import 'package:note_app/SQLlite.dart';
import 'package:note_app/home.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notes'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                children: [
                  TextFormField(
                    controller: note,
                    decoration: InputDecoration(
                      hintText: 'note',
                    ),
                  ),
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      hintText: 'title',
                    ),
                  ),
                  TextFormField(
                    controller: color,
                    decoration: InputDecoration(
                      hintText: 'color',
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  MaterialButton(
                    child: Text('Add notes'),
                    onPressed: () async {
                      int response = await sqlDb.insertData('''
INSERT INTO notes ('note','title','color') VALUES ('${note.text}' , '${title.text}' , '${color.text}')
''');
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                            (route) => false);
                      }
                    },
                    textColor: Colors.white,
                    color: Colors.amber,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
