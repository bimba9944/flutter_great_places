import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/screens/add_place_screen.dart';

class PlacesListScreen extends StatefulWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  State<PlacesListScreen> createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  List<Place> items = [];

  @override
  void initState() {
    fetchAndSetPlaces();
    super.initState();
  }

  void addPlace(File image, String title) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: null,
    );
    items.add(newPlace);
    setState(() {});
    DBHelper.insert('user_places', {'id': newPlace.id, 'title': newPlace.title, 'image': newPlace.image.path});
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    items = dataList
        .map(
          (item) => Place(id: item['id'], title: item['title'], image: File(item['image']), location: null),
        )
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => AddPlaceScreen(addPlace: addPlace),
                  ),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text('Nothing to show'))
          : FutureBuilder(
              future: fetchAndSetPlaces(),
              builder: (ctx, snapshot) => ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(items[index].image),
                        ),
                        title: Text(items[index].title),
                        onTap: () {},
                      ),
                    ),
            ),
    );
  }
}
