import 'package:insure_mate/db_helper/shared_preference/app_shared_preference.dart';

class HomeService {

  String? currentUserFirstName;

  Future<void> getLoggedInUserData() async{
    final firstName = _getLoggedInUserFirstName();
    final fullName = _getLoggedInUserFullName();

    final results = await Future.wait([firstName, fullName]);

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
}