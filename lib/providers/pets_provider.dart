import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/models/location_model.dart';
import '../models/petad_model.dart';

class PetsProvider {
  static final String _petsCollectionName = 'pets';
  final CollectionReference _petsCollection = Firestore.instance.collection(_petsCollectionName);
  
  CollectionReference get petsCollection => _petsCollection;

  Stream<List<PetAd>> fetchPetAds() {
    return _petsCollection.snapshots()
    .map((snapshot) => snapshot.documents.map((document) => PetAd.fromJson(document.data)).toList());
  }
  Stream<List<PetAd>> fetchPetAdsByLocation(Location location) {
    return this.fetchPetAds().forEach((snapshot) => snapshot.where((petAd) => petAd.location.calculateDistance(location.geoPoint) < 1000)).asStream();
  }
}