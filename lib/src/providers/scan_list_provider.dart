import 'package:flutter/material.dart';
import 'package:qr_reader/src/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    //Asignar el ID de la BD al modelo
    nuevoScan.id = id;

    if (this.tipoSeleccionado == nuevoScan.tipo) {
      this.scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

  loadScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans!];
    notifyListeners();
  }

  loadScansForType(String tipo) async {
    final scans = await DBProvider.db.getScansForType(tipo);
    this.scans = [...scans!];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  deleteAll() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  deleteScansById(int id) async {
    await DBProvider.db.deleteScan(id);
    // this.loadScansForType(this.tipoSeleccionado);
  }
}
