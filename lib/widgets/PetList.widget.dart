import 'package:flutter/material.dart';
import 'package:pet_app/providers/pets_provider.dart';
import '../models/petad_model.dart';

class PetList extends StatelessWidget {
  final String collectionName = "pets";
  final PetsProvider _petsProvider = new PetsProvider();

  final leftSection = new Container(
      padding: EdgeInsets.only(left: 10.0), child: Icon(Icons.pets));

  Widget startSection(PetAd petAd) => Expanded(
        child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '${petAd.adType == AdType.lost ? PetAd.lost : PetAd.found} ${petAd.petType} ב${petAd.location.locationName}',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                    "שם: ${petAd.petName}, צבע: ${petAd.petColor}"),
                Text(
                    "פורסם ע\"י ${petAd.personName} בתאריך ${petAd.getFormatedDate()}"),
              ]),
        ),
      );

  final rightSection = new Container(
    child: Icon(Icons.arrow_right),
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PetAd>>(
      stream: this._petsProvider.fetchPetAds(),
      builder: (BuildContext context, AsyncSnapshot<List<PetAd>> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return ListView(
          children: snapshot.data.map((PetAd petAd) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  leftSection,
                  startSection(petAd),
                  rightSection
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
