import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {

  static final String LOGGED_IN_PERSON_ID = "logged_in_person_id";
  static final String LOGGED_IN_PERSON_FULL_NAME = "logged_in_person_full_name";
  static final String LOGGED_IN_PERSON_FIRST_NAME = "logged_in_person_first_name";

  static Future<void> saveLoggedInPersonId(String personId) async{
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(LOGGED_IN_PERSON_ID, personId);
  }

  static Future<String?> getLoggedInPersonId() async {
    final sharedPref = await SharedPreferences.getInstance();
    return await sharedPref.getString(LOGGED_IN_PERSON_ID);
  }

  static Future<void> saveLoggedInPersonFullName(String fullName) async{
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(LOGGED_IN_PERSON_FULL_NAME, fullName);
  }

  static Future<String?> getLoggedInPersonFullName() async {
    final sharedPref = await SharedPreferences.getInstance();
    return await sharedPref.getString(LOGGED_IN_PERSON_FULL_NAME);
  }

  static Future<void> saveLoggedInPersonFirstName(String fullName) async{
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString(LOGGED_IN_PERSON_FIRST_NAME, fullName);
  }

  static Future<String?> getLoggedInPersonFirstName() async {
    final sharedPref = await SharedPreferences.getInstance();
    return await sharedPref.getString(LOGGED_IN_PERSON_FIRST_NAME);
  }
}