import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Pages
import 'package:qr_reader/src/pages/home_page.dart';
import 'package:qr_reader/src/pages/mapa_page.dart';

//Providers
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/providers/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => UiProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => ScanListProvider()),
      ],
      child: MaterialApp(
        title: 'QR Reader',
        initialRoute: 'home',
        debugShowCheckedModeBanner: false,
        routes: {
          'home': (BuildContext context) => HomePage(),
          'map': (BuildContext context) => MapaPage(),
        },
        theme: ThemeData(
            primaryColor: Colors.deepPurple,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepPurple,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.deepPurple,
            )),
      ),
    );
  }
}
