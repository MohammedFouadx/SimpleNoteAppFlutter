
import 'package:note_taking_app/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {

  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  Future<Database> get database  async{

    if(_database != null){
      return _database!;

    }
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath() , "note_app.db"),
        onCreate: (db , version) async{
            await db.execute('''
            CREATE TABLE notes (
             id INTEGER PRIMARY KEY AUTOINCREMENT ,
             title TEXT,
             body TEXT , 
             creation_date DATE
            )
            ''');
    }, version: 1
    );

  }


  addNewNote(NoteModel note) async{
    var db = await database;
    db.insert("notes", note.toMap());
  }

  Future<dynamic> getNotes () async{
    final db = await database;
    var res = await db.query("notes");
    if(res.length == 0) {
      return null;
    }else{
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : Null;

    }
  }

  Future<int> deleteNote (int id) async{
    var db = await database;
    var count = db.rawDelete("DELETE FROM notes WHERE id = ?" , [id]) ;
    print("deleted");
    return count;
  }


}