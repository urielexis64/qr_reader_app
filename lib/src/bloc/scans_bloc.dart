import 'dart:async';

import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _scans = new ScansBloc._internal();

  factory ScansBloc() {
    return _scans;
  }

  ScansBloc._internal() {
    //Get Scans from database
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose() {
    _scansController?.close();
  }

  getScans() async {
    _scansController.sink.add(await DBProvider.db.getAllScans());
  }

  addScan(ScanModel newScan) async {
    await DBProvider.db.newScan(newScan);
    getScans();
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAll();
    getScans();
  }
}
