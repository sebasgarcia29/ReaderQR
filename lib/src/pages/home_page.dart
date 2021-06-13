import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
import 'package:qr_reader/src/providers/db_provider.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/providers/ui_provider.dart';

//Widget
import 'package:qr_reader/src/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/src/widgets/scan_button.dart';

//Pages
import 'package:qr_reader/src/pages/mapas_page.dart';
import 'package:qr_reader/src/pages/direcciones_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('History'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false).deleteAll();
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Obtener el selectedMenuOpt
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    //Insert data
    // final temScan = new ScanModel(valor: 'http://instagram.com');
    // DBProvider.db.nuevoScan(temScan);
    // Find by ID
    // DBProvider.db.getScanById(1).then((value) => print(value!.valor));
    // Select * from
    // DBProvider.db.getAllScans();
    // Select for type
    // DBProvider.db.getScansForType('http');
    // Eliminar todos los registros
    // DBProvider.db.deleteAllScans();

    //Usar el ScanListProvider

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansForType('geo');
        return MapasPage();
      case 1:
        scanListProvider.loadScansForType('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
