import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version=1;
  static final String _tableName='tasks';

  static Future<void> initDb()async{
    if(_db!=null){
      return;
    }else{
      try{
        String path='${await getDatabasesPath()}task.db';
        print("he");
        _db=await openDatabase(path,version: _version,onCreate: (Database db,int version)async{
          await db.execute('CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'title STRING,note TEXT,date STRING,'
              'startTime STRING,endTime STRING,'
              'remind INTEGER,repeat STRING,'
              'color INTEGER,isCompleted INTEGER)');
        });
      }catch(e){
        print("sad");
        print(e);
      }
    }
  }

  static Future<int> insert(Task task) async{
    print("insert");
    return await _db!.insert(_tableName, task.toMap());
  }
  static Future<int> delete(Task task) async{
    print("delete");
    return await _db!.delete(_tableName,where: 'id = ?',whereArgs: [task.id]);
  }
  static Future<int> deleteAll() async{
    print("delete");
    return await _db!.delete(_tableName);
  }
  static Future<List<Map<String,Object?>>> query() async{
    print("query");
    return await _db!.query(_tableName);
  }
  static Future<int> update(int id) async{
    print("update");
    return await _db!.rawUpdate('''
      UPDATE tasks SET isCompleted = ?
      WHERE id =  ?
     ''',[1,id]);
  }

}
