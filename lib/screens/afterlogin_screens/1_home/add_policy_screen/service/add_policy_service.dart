
import 'package:flutter/widgets.dart';
import 'package:insure_mate/generic_models/policy_model.dart';
import 'package:insure_mate/providers/policy_provider/policy_provider.dart';

class AddPolicyService extends ChangeNotifier {
  PolicyProvider? _policyProvider;

  AddPolicyService(){
    print("AddPolicyService init gets called");
  }

  void update(PolicyProvider provider) {
    print("Provider is $provider");
    _policyProvider = provider;
  }

  Future<bool> addPolicy(Policy policy) async {
    if (_policyProvider == null) return false;
    return await _policyProvider!.addPolicy(policy);
  }
}