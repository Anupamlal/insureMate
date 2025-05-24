import 'package:flutter/cupertino.dart';
import 'package:insure_mate/db_helper/dao/policy_dao.dart';
import 'package:insure_mate/db_helper/db_helper.dart';
import 'package:insure_mate/generic_models/policy_model.dart';
import 'package:insure_mate/generic_services/firebase_service_policies.dart';

class PolicyProvider extends ChangeNotifier {

  List<Policy> _allPolicies = [];

  ///events
  Future<bool> addPolicy(Policy policy) async {
     final check = PolicyDao.insert(policy);
     final isUploadedOnDB = FirebaseServicePolicies.addPolicyToFirebase(policy);

     final results = await Future.wait([check, isUploadedOnDB]);

     if (results[1]){
       PolicyDao.updatePolicy(policy.policyNo, true);
     }

     return true;
  }
}