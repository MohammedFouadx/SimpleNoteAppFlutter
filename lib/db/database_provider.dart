import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// class DatabaseProvider {
//
//
//   static Database? _db ;
//
//   Future<Database?> get db async{
//     if(_db == null){
//       _db= await iniDatabase();
//       return _db;
//     }else{
//       return _db;
//     }
//   }
//
//   iniDatabase ()  async{
//
//     String databasePath = await getDatabasesPath();
//     String path = join(databasePath , "note.db");
//     Database db = await openDatabase(path , onCreate: _onCreate , version: 1);
//     return db;
//
//   }
//
//   _onCreate (Database db , int version) async {
//     await db.execute('''
//       CREATE TABLE "notes" (
//          "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
//          "title" TEXT NOT NULL ,
//          "body" TEXT ,
//          "creation_date" DATE
//       )
//       '''
//     );
//   }
//
//   /// select
//   getData (String sql) async{
//     Database? myDb = await db;
//     List<Map> response = await myDb!.rawQuery(sql);
//     return response;
//   }
//
//
//   /// insert
//   addData (String sql) async{
//     Database? myDb = await db;
//     int response = await myDb!.rawInsert(sql);
//     return response;
//   }
//
//
//   /// update
//   updateData (String sql) async{
//     Database? myDb = await db;
//     int response = await myDb!.rawUpdate(sql);
//     return response;
//   }
//
//   /// delete
//   deleteData (String sql) async{
//     Database? myDb = await db;
//     int response = await myDb!.rawDelete(sql);
//     return response;
//   }
//
// }



import 'package:get/get.dart';
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


  /// insert
  addNewNote(NoteModel note) async{
    var db = await database;
    db.insert("notes", note.toMap());
  }


  /// select all
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

  /// update
  Future<int> updateNote (String title , String body , int id) async{
    var db = await database;
    int count = await db.rawUpdate('UPDATE notes SET title = "$title", body = "$body"  WHERE id = ?', [id]);
    print("updated" + count.toString());
    return count;

  }


  /// delete
  Future<int> deleteNote (int id) async{
    var db = await database;
    var count = db.rawDelete("DELETE FROM notes WHERE id = ?" , [id]) ;
    print("deleted");
    return count;
  }


}

