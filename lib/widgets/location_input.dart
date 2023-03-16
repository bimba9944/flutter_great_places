import 'package:flutter/material.dart';
import 'package:great_places/helpers/map_helper.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  double? latitude;
  double? longitude;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    latitude = locData.latitude!;
    longitude = locData.longitude!;
    setState(() {});
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
          child: latitude == null ? const Center(child: Text('Nothing to show'),) : MapHelper(latitude!, longitude!),
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
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
            ),
          ],
        )
      ],
    );
  }
}
