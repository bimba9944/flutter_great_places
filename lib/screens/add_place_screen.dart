import 'package:flutter/material.dart';
import 'package:great_places/widgets/image_input.dart';
import 'dart:io';

class AddPlaceScreen extends StatefulWidget {
  final Function addPlace;
  const AddPlaceScreen({required this.addPlace,Key? key}) : super(key: key);


  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleControler = TextEditingController();
  File? _pickedImage;


  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleControler.text.isEmpty || _pickedImage == null) {
      return;
    }
    widget.addPlace(_pickedImage!, _titleControler.text);
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
