import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/widgets/image_input.dart';
import 'dart:io';

import 'package:great_places/widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  final Function addPlace;
  const AddPlaceScreen({required this.addPlace,Key? key}) : super(key: key);


  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleControler = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;


  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng){
    _pickedLocation = PlaceLocation(latitude: lat,longitude: lng);
  }

  void _savePlace() {
    if (_titleControler.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }
    widget.addPlace(_pickedImage!, _titleControler.text,_pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleControler,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    const SizedBox(height: 10),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Add place'),
            style: ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0,
              primary: Theme.of(context).colorScheme.secondary,
            ),
          )
        ],
      ),
    );
  }
}
