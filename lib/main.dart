import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Pages
import 'package:qr_reader/src/pages/home_page.dart';
import 'package:qr_reader/src/pages/maps_page.dart';
import 'package:qr_reader/src/providers/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => UiProvider()),
      ],
      child: MaterialApp(
        title: 'QR Reader',
        initialRoute: 'home',
        debugShowCheckedModeBanner: false,
        routes: {
          'home': (BuildContext context) => HomePage(),
          'map': (BuildContext context) => MapsScreen(),
        },
        theme: ThemeData.dark().copyWith(),
      ),
    );
  }
}
