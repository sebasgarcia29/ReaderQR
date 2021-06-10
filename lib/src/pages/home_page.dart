import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
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
            onPressed: () {},
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
    switch (currentIndex) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
