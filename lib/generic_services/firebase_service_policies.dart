import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insure_mate/generic_models/policy_model.dart';
import 'package:insure_mate/helper/firebase_keys.dart';

import '../db_helper/shared_preference/app_shared_preference.dart';

class FirebaseServicePolicies {

  static Future<bool> addPolicyToFirebase(Policy policy) async{

    final loggedInUserID = await AppSharedPreference.getLoggedInPersonId();

    final policyRef = FirebaseFirestore.instance
        .collection(FirebaseKeys.users)
        .doc(loggedInUserID)
        .collection(FirebaseKeys.policies)
        .doc(policy.policyNo);

    await policyRef.set(policy.toJson(isForFirebase: true));

    return true;

  }
}