import 'package:flutter/material.dart';
import 'package:great_places/helpers/map_helper.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput(this.onSelectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  double? latitude;
  double? longitude;

  void _showPreview(double lat, double lng) {
    latitude = lat;
    longitude = lng;
    setState(() {});
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _changePage() async {
    final location = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(builder: (context) => const MapScreen()),
    );
    if (location == null) {
      return;
    }
    _showPreview(location.latitude, location.longitude);
    widget.onSelectPlace(location.latitude, location.longitude);
  }

  Widget _setMapPreview() {
    return MapHelper(latitude!, longitude!);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: latitude == null ? const Center(child: Text('Nothing to show'),) : _setMapPreview(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: _changePage,
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
            ),
          ],
        )
      ],
    );
  }
}
