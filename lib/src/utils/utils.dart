
import 'package:app_flutter_qrscanner/src/models/scan_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

abrirScan(BuildContext context, ScanModel scanModel) async {
  if(scanModel.tipo == 'http') {
    if (await canLaunch(scanModel.valor)) {
      await launch(scanModel.valor);
    } else {
      throw 'Could not launch ${scanModel.valor}';
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scanModel);
  }
  
}