import 'package:sqflite/sqflite.dart';
import 'package:sqlflutter/model/koneksidatabase.dart';
class Repository {

  late Koneksidatabase _databaseConnection;

  Repository() {
    _databaseConnection = Koneksidatabase();
  }

  static Database? _database;
  Future<Database?>get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'kode=?', whereArgs: [itemId]);
  }

  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'kode=?', whereArgs: [data['kode']]);
  }

  deleteDataBykode(table, kode) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where kode='$kode'");
  }

}