import 'package:insure_mate/db_helper/dao/person_dao.dart';
import 'package:insure_mate/db_helper/shared_preference/app_shared_preference.dart';
import 'package:insure_mate/generic_services/firebase_service.dart';

class LoginService {

  static Future<bool> signUpUsingGoogle() async {

    bool isSignUpDone = await FirebaseService.initGoogleSignUp();

    if (isSignUpDone) {
      var personModel = await FirebaseService.saveUserProfileOnFirebase();

      if (personModel != null) {
        bool isUserSaved = await PersonDao.insert(personModel);

        AppSharedPreference.saveLoggedInPersonId(personModel.id);

        if (personModel.fullName != null) {
          AppSharedPreference.saveLoggedInPersonFullName(personModel.fullName!);
          List<String> parts = personModel.fullName!.split(' ');
          String firstName = parts.first;
          AppSharedPreference.saveLoggedInPersonFirstName(firstName);

          return true;
        }

      }
    }

    return false;
  }
}