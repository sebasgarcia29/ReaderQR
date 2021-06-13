import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:qr_reader/src/models/scan_model.dart';
export 'package:qr_reader/src/models/scan_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    // ignore: unnecessary_null_comparison
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    // Path donde se almacena la BD
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    //Crear BD
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )
        ''');
      },
    );
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    //verificar la BD
    final db = await database;
    final result = await db!.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
        VALUES( $id, '$tipo', '$valor')
    ''');
    return result;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final result = await db!.insert('Scans', nuevoScan.toJson());
    // Result is the ID final insert in Table Scans
    return result;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final result = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? ScanModel.fromJson(result.first) : null;
  }

  Future<List<ScanModel>?> getAllScans() async {
    final db = await database;
    final result = await db!.query('Scans');
    return result.isNotEmpty
        ? result.map((s) => ScanModel.fromJson(s)).toList()
        : [];
  }

  Future<List<ScanModel>?> getScansForType(String tipo) async {
    final db = await database;
    final result = await db!.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');
    return result.isNotEmpty
        ? result.map((s) => ScanModel.fromJson(s)).toList()
        : [];
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final result = db!.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return result;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final result = db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    // Dos alternativas, por SQL o por metodo
    // final result = db!.delete('Scans');
    final result = db!.rawDelete('''
      DELETE FROM Scans
    ''');
    return result;
  }
}
