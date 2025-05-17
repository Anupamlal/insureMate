import 'package:firebase_auth/firebase_auth.dart';

class PersonModel {
  final String? fullName;
  final String? email;
  final String id;
  String? profilePhotoURL;

  PersonModel({this.fullName = "", this.email = "", required this.id, this.profilePhotoURL = null});

  factory PersonModel.fromJSON(Map<String, dynamic> json){
    final String fullName = json["fullName"];
    final String email = json["email"];
    final String id = json["id"];
    String? profilePhotoURL = json["profilePhotoURL"];

    return PersonModel(id: id, fullName: fullName, email: email, profilePhotoURL: profilePhotoURL);
  }

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'id': id,
    'profilePhotoURL': profilePhotoURL,
  };
}