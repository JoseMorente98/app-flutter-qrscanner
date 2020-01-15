import 'package:app_flutter_qrscanner/src/pages/direcciones_page.dart';
import 'package:app_flutter_qrscanner/src/pages/mapas_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottom(),
    );
  }

  _crearBottom() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        currentIndex = index;
        setState(() {
          
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Container()
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Container()
        )
      ],
    );
  }

  _callPage(int page) {
    switch(page) {
      case 0:
      return MapasPage();
      case 1:
      return DireccionesPage();
      default: 
      return MapasPage();
    }
  }
}