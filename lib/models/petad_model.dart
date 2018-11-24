import 'location_model.dart';
import 'package:intl/intl.dart';

class PetAd {
  static final String lost = "אבד";
  static final String found = "נמצא";

  String petName;
  String petColor;
  String petType;
  AdType adType;
  DateTime foundLostDate;
  String personName;
  Location location;
  String phoneNumber;
  int reward;
  String comment;

  PetAd(this.petName, this.petColor,this.petType, this.adType, this.foundLostDate, 
        this.personName, this.location, this.phoneNumber, 
        this.reward, this.comment);

  PetAd.fromJson(Map<String, dynamic> document): this(document["petName"], 
                                                      document["petColor"], 
                                                      document["petType"],
                                                      document["foundLost"] == PetAd.found ? AdType.found : AdType.lost,
                                                      document["foundLostDate"],
                                                      document["personName"],
                                                      Location(document["location"], document["foundLostAt"]),
                                                      document["phoneNumber"],
                                                      document["reward"],
                                                      document["comment"]);

  String getFormatedDate() {
    return DateFormat('dd/MM/yy').format(this.foundLostDate);
  }
}

enum AdType {
  lost, found
}