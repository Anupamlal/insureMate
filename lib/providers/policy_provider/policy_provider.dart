import 'dart:async';

import 'package:cloud_firestore_platform_interface/src/pigeon/messages.pigeon.dart';
import 'package:flutter/cupertino.dart';
import 'package:insure_mate/db_helper/dao/policy_dao.dart';
import 'package:insure_mate/db_helper/db_helper.dart';
import 'package:insure_mate/generic_models/policy_model.dart';
import 'package:insure_mate/generic_services/firebase_service_policies.dart';
import 'package:intl/find_locale.dart';

class PolicyProvider extends ChangeNotifier {
  List<Policy> _allPolicies = [];
  bool _isFirstTimeSync = true;
  StreamSubscription? _firebaseRef;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firebaseRef?.cancel();
    _firebaseRef = null;
  }

  List<Policy> getAllPolicies() => _allPolicies;

  void fetchAllPolicies() async {
    _allPolicies = await PolicyDao.getAllPolicies();
    notifyListeners();

    _addAllPolicyListener();
  }

  void _addAllPolicyListener() async {
    final ref = await FirebaseServicePolicies.getDatabaseRefForListener();

    _firebaseRef = ref.snapshots().listen((snapshot) async {
      if (_isFirstTimeSync) {
        /// First time sync after login or relaunch
        final policies =
            snapshot.docs.map((value) {
              final policy = Policy.fromJSON(value.data());
              policy.isUploaded = true;
              return policy;
            }).toList();

        _isFirstTimeSync = false;
        _allPolicies = policies;

        await PolicyDao.insertAll(policies);
      } else {
        /// Any update in policy
        final allChanges = snapshot.docChanges;

        for (var change in allChanges) {
          final data = change.doc.data();

          if (data == null) continue;

          final policy = Policy.fromJSON(data);
          policy.isUploaded = true;

          final index = _allPolicies.indexWhere(
            (p) => p.policyNo == policy.policyNo,
          );

          switch (change.type) {
            case DocumentChangeType.added:
            case DocumentChangeType.modified:
              if (index != -1) {
                _allPolicies[index] = policy;
              } else {
                _allPolicies.add(policy);
              }
              PolicyDao.upsert(policy);

            case DocumentChangeType.removed:
              if (index != -1) {
                _allPolicies.removeAt(index);
                PolicyDao.deletePolicy(policy);
              } else {
                continue;
              }
          }
        }
      }
      notifyListeners();
    });
  }

  Future<bool> addPolicy(Policy policy) async {
    final check = await PolicyDao.upsert(policy);

    FirebaseServicePolicies.addPolicyToFirebase(policy);

    return check;
  }
}
