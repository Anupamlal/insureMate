import 'package:insure_mate/db_helper/dao/person_dao.dart';
import 'package:insure_mate/db_helper/shared_preference/app_shared_preference.dart';
import 'package:insure_mate/generic_models/person_model.dart';

class HomeService {

  String? currentUserFirstName;
  String? currentUserID;
  String? currentUserImage;

  Future<void> getLoggedInUserData() async{
    final firstName = _getLoggedInUserFirstName();
    final fullName = _getLoggedInUserFullName();
    final userImageURL = _getLoggedInUserImageURL();

    final results = await Future.wait([firstName, fullName, userImageURL]);

    currentUserFirstName = results[0];
  }

  Future<String> _getLoggedInUserFirstName() async{
    final firstName = await AppSharedPreference.getLoggedInPersonFirstName();

    if (firstName != null) {
      return firstName;
    }

    return "";
  }

  Future<String> _getLoggedInUserFullName() async{
    final fullName = await AppSharedPreference.getLoggedInPersonFullName();

    if (fullName != null) {
      return fullName;
    }

    return "";
  }

  Future<String?> _getLoggedInUserImageURL() async{
    final loggedInUserID = await AppSharedPreference.getLoggedInPersonId();
    if (loggedInUserID != null) {
      final PersonModel person = await PersonDao.getPersonModel(loggedInUserID);
      currentUserID = loggedInUserID;

      currentUserImage = person.profilePhotoURL;
      return currentUserImage;
    }

    return null;
  }
}