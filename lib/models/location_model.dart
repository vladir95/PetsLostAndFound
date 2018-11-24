import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class Location {
  GeoPoint geoPoint;
  String locationName;

  Location(this.geoPoint, this.locationName);

  double calculateDistance(GeoPoint to) {
    var R = 6371;
    var dLat = deg2rad(to.latitude - this.geoPoint.latitude);
    var dLon = deg2rad(to.latitude - this.geoPoint.latitude);
    var a = sin(dLat / 2) * sin(dLat / 2) +
      cos (deg2rad(this.geoPoint.latitude)) * cos(deg2rad(to.latitude)) *
      sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R*c;
  }

  double deg2rad(deg) {
      return deg * (pi/180);
  }
}
