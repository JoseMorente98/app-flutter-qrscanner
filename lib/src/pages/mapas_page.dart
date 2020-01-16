import 'package:app_flutter_qrscanner/src/bloc/scans_bloc.dart';
import 'package:app_flutter_qrscanner/src/models/scan_model.dart';
import 'package:app_flutter_qrscanner/src/providers/db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final scansBloc = new ScansBloc();


    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStrem,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        final scans = snapshot.data;
        if(scans.length == 0) {
          return Center(
            child: Text('No hay información'),
          ) ;
        }
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.redAccent,),
            onDismissed: (direction) {
              //DBProvider.db.deleteScan(scans[i].id);
              scansBloc.borrarScan(scans[i].id);
            },
            child: ListTile(
              leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor,),
              title: Text(scans[i].valor),
              subtitle: Text('ID ${scans[i].id}'),
              trailing: Icon(Icons.arrow_right, color: Colors.grey,),
            ),
          ),
        );
      },
    );
  }
}