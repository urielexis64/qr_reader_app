import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScanModel>>(
      future: DBProvider.db.getAllScans(),
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (snapshot.hasData) {
          final scans = snapshot.data;

          if (scans.length == 0) {
            return Center(
              child: Text('There\'s no info'),
            );
          }

          return ListView.builder(
              itemCount: scans.length,
              itemBuilder: (context, i) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (dir) {
                    DBProvider.db.deleteScan(scans[i].id);
                  },
                  background: Container(
                    color: Colors.redAccent,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.cloud),
                    title: Text(scans[i].value),
                    subtitle: Text('ID: ${scans[i].id}'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                );
              });
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
