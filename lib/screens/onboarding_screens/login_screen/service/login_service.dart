import 'package:insure_mate/db_helper/dao/person_dao.dart';
import 'package:insure_mate/generic_services/firebase_service.dart';

class LoginService {

  static Future<bool> signUpUsingGoogle() async {

    bool isSignUpDone = await FirebaseService.initGoogleSignUp();

    if (isSignUpDone) {
      var personModel = await FirebaseService.saveUserProfileOnFirebase();

      if (personModel != null) {
        return PersonDao.insert(personModel);
      }
    }

    return false;
  }
}