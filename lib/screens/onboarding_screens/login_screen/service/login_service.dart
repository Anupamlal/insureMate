import 'package:insure_mate/generic_services/firebase_service.dart';

class LoginService {

  static Future<bool> signUpUsingGoogle() async {

    bool isSignUpDone = await FirebaseService.initGoogleSignUp();

    if (isSignUpDone) {
      return await FirebaseService.saveUserProfileOnFirebase();
    }

    return false;
  }
}