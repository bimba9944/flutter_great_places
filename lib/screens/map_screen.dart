import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen();

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  void _handleTap(tapPosition, LatLng latlng) {
    setState(() {
      tappedPoints = [];
      tappedPoints.add(latlng);
    });
  }

  List<LatLng> tappedPoints = [];

  @override
  Widget build(BuildContext context) {
    final markers = tappedPoints.map((latlng) {
      return Marker(point: latlng, builder: (ctx) => const Icon(Icons.place));
    }).toList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map'),
          actions: [
            if (tappedPoints.isNotEmpty)
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  Navigator.of(context).pop(tappedPoints[0]);
                },
              )
          ],
        ),
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(37.422, -122.084),
            zoom: 9.2,
            onTap: _handleTap,
          ),
          nonRotatedChildren: [
            AttributionWidget.defaultWidget(source: 'OpenStreetMap contributors', onSourceTapped: null),
          ],
          layers: [
            TileLayerOptions(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
            MarkerLayerOptions(markers: markers),
          ],
        ));
  }
}
