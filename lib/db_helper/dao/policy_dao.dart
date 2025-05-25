import 'package:insure_mate/generic_models/policy_model.dart';
import 'package:sqflite/sqflite.dart';

import '../db_helper.dart';

class PolicyDao {
  static final String POLICY_TABLE = "policy";
  static final String COLUMN_POLICYHOLDER_NAME = "policyholder_name";
  static final String COLUMN_POLICY_NO = "policy_no";
  static final String COLUMN_PHONE_NO = "phone_number";
  static final String COLUMN_PREMIUM_AMOUNT = "premium_amount";
  static final String COLUMN_PREMIUM_MODE = "premium_mode";
  static final String COLUMN_START_DATE = "start_date";
  static final String COLUMN_FUP_DATE = "fup_date";
  static final String COLUMN_NOTES = "notes";
  static final String COLUMN_NEXT_DUE_DATE = "next_due_date";
  static final String COLUMN_IS_UPLOADED = "is_uploaded";

  static Future<bool> upsert(Policy policy) async {
    final db = await DbHelper.getInstance.getDB();
    int rowsAffected = await db.insert(
      POLICY_TABLE,
      policy.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return rowsAffected > 0;
  }

  static Future<List<Policy>> getAllPolicies() async {
    final db = await DbHelper.getInstance.getDB();
    final allPolicies = await db.query(POLICY_TABLE);
    return allPolicies.map((policy) {
      return Policy.fromJSON(policy);
    }).toList();
  }

  static Future<Policy> getPolicy(String policyNo) async {
    final db = await DbHelper.getInstance.getDB();
    final allPolicies = await db.query(
      POLICY_TABLE,
      where: '$COLUMN_POLICY_NO = ?',
      whereArgs: [policyNo],
    );

    return Policy.fromJSON(allPolicies.first);
  }

  static Future<bool> updatePolicy(String policyNo, bool isUploaded) async {
    final db = await DbHelper.getInstance.getDB();

    int rowsAffected = await db.update(
      POLICY_TABLE,
      {COLUMN_IS_UPLOADED: isUploaded ? 1 : 0},
      where: '$COLUMN_POLICY_NO = ?',
      whereArgs: [policyNo],
    );

    return rowsAffected > 0;
  }

  static Future<void> insertAll(List<Policy> policies) async {
    final db = await DbHelper.getInstance.getDB();
    final batch = db.batch();
    for (var policy in policies) {
      batch.insert(
        POLICY_TABLE,
        policy.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  static Future<bool> deletePolicy(Policy policy) async {
    final db = await DbHelper.getInstance.getDB();

    int rowsAffected = await db.delete(
      POLICY_TABLE,
      where: '$COLUMN_POLICY_NO = ?',
      whereArgs: [policy.policyNo],
    );

    return rowsAffected > 0;
  }
}
