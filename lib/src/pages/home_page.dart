import 'package:app_flutter_qrscanner/src/bloc/scans_bloc.dart';
import 'package:app_flutter_qrscanner/src/models/scan_model.dart';
import 'package:app_flutter_qrscanner/src/pages/direcciones_page.dart';
import 'package:app_flutter_qrscanner/src/pages/mapas_page.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(onPressed: scansBloc.borrarTodos, icon: Icon(Icons.delete),)
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
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
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
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

  void _scanQR() async {
    String futureString = 'https://josemorente98.github.io/';
    //https://josemorente98.github.io/
    //geo:14.642052302306546,-90.5137576146973
    /*try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = futureString = e.toString();
    }
    print("FUTURE " + futureString);*/

    if(futureString != null) {
      final scanModel = ScanModel( valor: futureString );
      //DBProvider.db.nuevoScan(scanModel);
      scansBloc.agregarScan(scanModel);

      final scanModel2 = ScanModel( valor: 'geo:14.642052302306546,-90.5137576146973' );
      scansBloc.agregarScan(scanModel2);
    }
  }
}