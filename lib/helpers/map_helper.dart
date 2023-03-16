import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

class MapHelper extends StatelessWidget {
  double? latitude;
  double? longitude;

  MapHelper(this.latitude, this.longitude, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(center: LatLng(latitude!, longitude!), zoom: 9.2),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(source: 'OpenStreetMap contributors', onSourceTapped: null),
      ],
      layers: [
        TileLayerOptions(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayerOptions(markers: [Marker(point: LatLng(latitude!,longitude!), builder: (context) => Icon(Icons.place))]),
      ],
    );
  }
}
