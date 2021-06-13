import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//Provider
import 'package:qr_reader/src/providers/db_provider.dart';

launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.valor;

  if (scan.tipo == 'http') {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se puede navegar a $url';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
