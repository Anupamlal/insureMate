import 'package:firebase_auth/firebase_auth.dart';

class PersonModel {
  final String? fullName;
  final String? email;
  final String id;
  String? profilePhotoURL;

  PersonModel({this.fullName = "", this.email = "", required this.id, this.profilePhotoURL = null});

  factory PersonModel.fromJSON(Map<String, dynamic> json){
    final String fullName = json["full_name"];
    final String email = json["email"];
    final String id = json["person_id"];
    String? profilePhotoURL = json["profile_photo_url"];

    return PersonModel(id: id, fullName: fullName, email: email, profilePhotoURL: profilePhotoURL);
  }

  Map<String, dynamic> toJson() => {
    'full_name': fullName,
    'email': email,
    'person_id': id,
    'profile_photo_url': profilePhotoURL,
  };
}