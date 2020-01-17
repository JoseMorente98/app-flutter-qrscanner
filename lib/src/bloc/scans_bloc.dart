import 'dart:async';

import 'package:app_flutter_qrscanner/src/bloc/validator.dart';
import 'package:app_flutter_qrscanner/src/models/scan_model.dart';
import 'package:app_flutter_qrscanner/src/providers/db_provider.dart';

class ScansBloc with Validator {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }
  
  ScansBloc._internal() {
    //OBTENER INFORMACION
    obtenerScans();
  }

  final _scansBlocController = StreamController<List<ScanModel>>.broadcast();
  Stream<List<ScanModel>> get scansStrem => _scansBlocController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStremHttp => _scansBlocController.stream.transform(validarHttp);

  void dispose() {     
    _scansBlocController?.close();
  }

  agregarScan(ScanModel scanModel) async {
    await DBProvider.db.nuevoScan(scanModel);
    obtenerScans();
  }

  obtenerScans() async {
    _scansBlocController.sink.add(await DBProvider.db.getTodosScan());
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }

}