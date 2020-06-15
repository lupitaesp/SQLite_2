import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'students.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'convertidor.dart';



class DBHelper {
  static Database _db;
  static const String Id = 'controlum';
  static const String NAME = 'name';
  static const String SURNAME = 'surname';
  static const String AP = 'ap';
  static const String MAT = 'mat';
  static const String MAIL = 'mail';
  static const String NUM = 'num';
  static const String TABLE = 'Students';
  static const String DB_NAME = 'students6.db';
  static const String photoName = 'photoName';



//creacion de la base de datos

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    else {
      _db = await initDb();
      return _db;
    }
  }

  initDb() async {
    io.Directory appDirectory = await getApplicationDocumentsDirectory();
    print(appDirectory);
    String path = join(appDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }


  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($Id INTEGER PRIMARY KEY, $NAME TEXT, $SURNAME TEXT, $AP TEXT, $MAT TEXT, $MAIL TEXT, $NUM TEXT, $photoName BLOB)");
  }

//Equivalente a select
  Future<List<Student>> getStudents() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [Id, NAME, SURNAME, AP,MAT, MAIL, NUM,photoName]);
    List<Student> studentss = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        studentss.add(Student.fromMap(maps[i]));
      }
    }
    return studentss;
  }

  /*Future<List<Student>> getPhotos () async{
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,columns: [Id,photoName]);
    List<Student> photos = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        photos.add(Student.fromMap(maps[i]));
      }
    }
    return photos;
  }*/

  //save o insert
  //Modificacion para la matricula
  Future<bool> validateInsert(Student student) async {
    var dbClient = await db;
    var code = student.mat;
    List<Map> maps = await dbClient
    //CONSULTA SI LA MATRICULA SE ENCUENTRA EN LA BASE
        .rawQuery("select $Id from $TABLE where $MAT = $code");
    if (maps.length == 0) {
      return true;
    }else{
      return false;
    }
  }



//Busqueda
  Future<List<Student>>select(String buscar) async{
    print("ENTRANDO AL SELECT");
    final bd = await db;
    //CONSULTA DE LA BASE PARA EL SELECT
    List<Map> maps = await bd.rawQuery("SELECT * FROM $TABLE WHERE $MAT LIKE '$buscar%'");
    List<Student> studentss =[];
    print(maps);
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++){
        studentss.add(Student.fromMap(maps[i]));
      }
    }
    return studentss;
  }

  Future<Student> insert(Student student) async {
    var dbClient = await db;
    student.controlum = await dbClient.insert(TABLE, student.toMap());
  }

//Delete
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$Id = ?', whereArgs: [id]);
  }

//Update
  Future<int> update(Student student) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, student.toMap(), where: '$Id = ?',
        whereArgs: [student.controlum]);
  }

//Close Database
  Future closedb() async {
    var dbClient = await db;
    dbClient.close();
  }
}