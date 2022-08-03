import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'hossam.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 4, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    print("onUpgrade =====================================");
    await db.execute('ALTER TABLE notes ADD COLUMN color TEXT');
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    //lo 3azy 2create 2ktr mn tables

    batch.execute('''
        CREATE TABLE "students"(
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
    title TEXT NOT NULL, 
    "note" TEXT NOT NULL
    )
''');

    await batch.commit();

    await db.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
    title TEXT NOT NULL, 
    "note" TEXT NOT NULL
  )
 ''');
 //hena lo enta 3ayz tdeef gadwal wa7ed bas 
    print(" onCreate =====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

// SELECT
// DELETE
// UPDATE
// INSERT

  mydeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'hossam.dbb');
    await deleteDatabase(path);
  }
}
