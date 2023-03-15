import 'dart:io';

class PlaceLocation{
  final double latitude;
  final double longitude;
  final String? adress;

  PlaceLocation({this.adress,required this.latitude,required this.longitude});
}

class Place{
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({required this.image,required this.title,required this.id,required this.location});
}