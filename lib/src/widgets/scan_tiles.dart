import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
import 'package:qr_reader/src/providers/scan_list_provider.dart';
//Utils
import 'package:qr_reader/src/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;

  const ScanTiles({required this.tipo});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .deleteScansById(scans[i].id!);
        },
        child: ListTile(
          leading: Icon(
            this.tipo == 'http' ? Icons.http : Icons.map,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scans[i].valor),
          subtitle: Text(scans[i].id.toString()),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            launchURL(context, scans[i]);
          },
        ),
      ),
    );
  }
}
