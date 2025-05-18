import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insure_mate/extensions/string_extensions.dart';
import 'package:insure_mate/generic_models/person_model.dart';
import 'package:insure_mate/helper/firebase_keys.dart';

class FirebaseService {

  static Future<bool> initGoogleSignUp() async {

    final user = await GoogleSignIn().signIn();

    if (user != null) {

      GoogleSignInAuthentication auth = await user.authentication;

      var credential = GoogleAuthProvider.credential(accessToken: auth.accessToken, idToken: auth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      return FirebaseAuth.instance.currentUser != null;

    }

    return false;
  }

  static Future<PersonModel?> saveUserProfileOnFirebase() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && currentUser.email != null) {

      String emailAsID = currentUser.email!.makeEmailAsID();

      PersonModel person = PersonModel(id: currentUser.uid, fullName: currentUser.displayName, email: currentUser.email, profilePhotoURL: currentUser.photoURL);

      final dbRef = FirebaseDatabase.instance.ref();

      await dbRef.child(FirebaseKeys.users).child(emailAsID).child(FirebaseKeys.userInfo).set(person.toJson());

      return person;
    }

    return null;
  }
}