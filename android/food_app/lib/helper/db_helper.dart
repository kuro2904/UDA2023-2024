import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper{
  static final DBHelper _instance = DBHelper._();
  static Database? _database;

  DBHelper._();

  factory DBHelper() => _instance;

  // Future<Database> getDatabase() async{
  //   if(_database != null){
  //     return _database!;
  //   }else{
  //     _database = await initDatabase();
  //     return _database!;
  //   }
  // }

  // Future<Database> initDatabase() async{
  //   final databasePath = await getDatabasesPath();
  //   final path = join(databasePath, 'food_app.db');
  //   return openDatabase(path,version: 1,onCreate: _onCreate);
  // }

  // Future<void> _onCreate(Database db, int version) async{
  //   String sql = 'CREATE TABLE USER(id TEXT, email TEXT, password TEXT, phoneNumber TEXT, address TEXT, authToken TEXT)';
  //   await db.execute(sql);
  // }



}