import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  GeoPoint geoPoint;
  String locationName;

  Location(this.geoPoint, this.locationName);
}