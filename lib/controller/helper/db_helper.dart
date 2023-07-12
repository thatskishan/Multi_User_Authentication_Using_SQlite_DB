import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/user_model.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();

  Database? db;

  Future<void> initDB() async {
    var directory = await getDatabasesPath();
    String path = join(directory, "userdata.db");

    db = await openDatabase(
      path,
      version: 5,
      onCreate: (Database db, int ver) async {
        String query =
            "CREATE TABLE IF NOT EXISTS user(Id INTEGER PRIMARY KEY AUTOINCREMENT,Name TEXT NOT NULL,Email TEXT NOT NULL, Password TEXT NOT NULL, Role TEXT NOT NULL);";
        await db.execute(query);
      },
    );
  }

  Future<int> insertRecord({required User user}) async {
    await initDB();

    String query =
        "INSERT INTO user(Name, Email, Password, Role) VALUES(?, ?, ?, ?);";

    List args = [user.name, user.email, user.password, user.role];

    return await db!.rawInsert(query, args);
  }

  Future<List<User>> fetchAllRecords() async {
    await initDB();

    String query = "SELECT * FROM user;";

    List<Map<String, dynamic>> allRecords = await db!.rawQuery(query);
    List<User> allUsers = allRecords.map((e) => User.fromMap(e)).toList();

    return allUsers;
  }

  Future<int> deleteRecord({required int id}) async {
    await initDB();

    String query = "DELETE FROM user WHERE Id=?";
    List args = [id];

    return await db!.rawDelete(query, args);
  }

  Future<int> updateRecord({required User user, required int id}) async {
    await initDB();

    String query =
        "UPDATE user SET Name=?, Email=?, Password=?, Role=? WHERE Id=?;";
    List args = [user.name, user.email, user.password, user.role, id];

    return await db!.rawUpdate(query, args);
  }
}
