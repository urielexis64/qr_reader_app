import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import "package:latlong/latlong.dart";

class MapPage extends StatelessWidget {
  final token =
      'pk.eyJ1IjoidXJpZWxleGlzNjQiLCJhIjoiY2treW5zd3BiMDg4dzJvcGx3OWYyZ201dyJ9.vFWYPMn2ZPKRA6hWfdXUMQ';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {},
          )
        ],
      ),
      body: _createFlutterMap(scan),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 18.0,
      ),
      layers: [_createMap()],
    );
  }

  TileLayerOptions _createMap() {
    return TileLayerOptions(
        urlTemplate:
            'https://api.mapbox.com/styles/v1/mapbox/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
        additionalOptions: {'accessToken': token, "id": 'satellite-v9'});
  }

  /*mapbox://styles/mapbox/streets-v11
Mapbox Outdoors	mapbox://styles/mapbox/outdoors-v11
Mapbox Light	mapbox://styles/mapbox/light-v10
Mapbox Dark	mapbox://styles/mapbox/dark-v10
Mapbox Satellite	mapbox://styles/mapbox/satellite-v9
Mapbox Satellite Streets	mapbox://styles/mapbox/satellite-streets-v11 */
}
