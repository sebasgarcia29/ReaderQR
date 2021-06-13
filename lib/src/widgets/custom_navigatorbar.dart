import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final uiProvider = Provider.of<UiProvider>(context);
  final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: (int i){
        uiProvider.selectedMenuOpt = i;
      },
      showUnselectedLabels: true,
      showSelectedLabels: true,
      elevation: 0,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.room), label: 'Map'),
        BottomNavigationBarItem(
            icon: Icon(Icons.language), label: 'Address'),
      ],
    );
  }
}
