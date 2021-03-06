import 'dart:io';

import 'package:app_flutter_qrscanner/src/models/scan_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database; 
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if ( _database != null ) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'ScannDB.db');
    return await openDatabase(
      path, 
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans('
            'id INTEGER PRIMARY KEY,'
            'tipo TEXT,'
            'valor TEXT'
          ');'
        );
      }
    );
  }


  //CREAR REGISTROS
  nuevoScanRaw( ScanModel nuevoScan ) async {
    final db  = await database;

    final res = await db.rawInsert(
      "INSERT Into Scans (id, tipo, valor) "
      "VALUES ( ${ nuevoScan.id }, '${ nuevoScan.tipo }', '${ nuevoScan.valor }' )"
    );
    return res;
  }


  nuevoScan(ScanModel scanModel) async {
    final db = await database;

    final res = await db.insert('Scans', scanModel.toJson());
    return res;
  }

  Future<ScanModel> getScanId(int id) async {
    final db = await database;

    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getTodosScan() async {
    final db = await database;

    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty
                          ? res.map((scan) => ScanModel.fromJson(scan)).toList()
                          : [];
    return list;
  }

  Future<List<ScanModel>> getScanByTipo(String tipo) async {
    final db = await database;

    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo = '$tipo'");

    List<ScanModel> list = res.isNotEmpty
                          ? res.map((scan) => ScanModel.fromJson(scan)).toList()
                          : [];
    return list;
  }

  //ACTUALIZAR
  Future<int> updateScan(ScanModel scanModel) async { 
    final db = await database;
    final res = await db.update('Scans', scanModel.toJson(), where: 'id = ?', whereArgs: [scanModel.id]);
    return res;
  }

  //ELIMINAR REGISTRO
  deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Scans');
    return res;
  }

}