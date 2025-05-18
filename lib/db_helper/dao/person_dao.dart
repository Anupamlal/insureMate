import 'package:insure_mate/db_helper/db_helper.dart';
import 'package:insure_mate/generic_models/person_model.dart';

class PersonDao {
  static final String PERSON_TABLE = "person";
  static final String COLUMN_PERSON_ID = "person_id";
  static final String COLUMN_FULL_NAME = "full_name";
  static final String COLUMN_EMAIL = "email";
  static final String COLUMN_PROFILE_PHOTO_URL = "profile_photo_url";

  static Future<bool> insert(PersonModel p) async {
    final db = await DbHelper.getInstance.getDB();
    int rowsAffected = await db.insert(PERSON_TABLE, p.toJson());
    return rowsAffected > 0;
  }

  static Future<List<PersonModel>> getAllPerson() async {
    final db = await DbHelper.getInstance.getDB();
    final allPerson = await db.query(PERSON_TABLE);
    return allPerson.map((person){
      return PersonModel.fromJSON(person);
    }).toList();
  }
  
  static Future<PersonModel> getPersonModel(String person_id) async {
    final db = await DbHelper.getInstance.getDB();
    final allPerson = await db.query(PERSON_TABLE, where: '$COLUMN_PERSON_ID = ?',
      whereArgs: [person_id],);

    return PersonModel.fromJSON(allPerson.first);
  }

}