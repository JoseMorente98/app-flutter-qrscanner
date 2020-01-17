import 'package:app_flutter_qrscanner/src/bloc/scans_bloc.dart';
import 'package:app_flutter_qrscanner/src/models/scan_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_qrscanner/src/utils/utils.dart' as utils;

class DireccionesPage extends StatelessWidget {
  
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.obtenerScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStremHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        
        if ( !snapshot.hasData ) {
          return Center(child: CircularProgressIndicator());
        }

        //final scans = snapshot.data;

        if ( snapshot.data.length == 0 ) {
          return Center(
            child: Text('No hay información'),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, i ) => Dismissible(
            key: UniqueKey(),
            background: Container( color: Colors.red ),
            onDismissed: ( direction ) => scansBloc.borrarScan(snapshot.data[i].id),
            child: ListTile(
              leading: Icon( Icons.map, color: Theme.of(context).primaryColor ),
              title: Text( snapshot.data[i].valor ),
              subtitle: Text('ID: ${ snapshot.data[i].id }'),
              trailing: Icon( Icons.keyboard_arrow_right, color: Colors.grey ),
              onTap: () => utils.abrirScan(context, snapshot.data[i]),
            )
          )          
        );


      },
    );

  }
}