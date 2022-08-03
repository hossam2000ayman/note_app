import 'package:flutter/material.dart';
import 'package:note_app/SQLlite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();

  Future<List<Map>> readData() async {
    List<Map> response = await sqlDb.readData('SELECT * FROM notes');
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('addnotes');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        child: ListView(
          children: [
            MaterialButton(
              child: Text('delete Database'),
              onPressed: () async {
                await sqlDb.mydeleteDatabase();
              },
            ),
            FutureBuilder(
              future: readData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  ListView.builder(
                    itemCount: snapshot.data!.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('${snapshot.data![index]['title']}'),
                          subtitle: Text('${snapshot.data![index]['note']}'),
                          trailing: Text('${snapshot.data![index]['color']}'),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
