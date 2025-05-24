
import 'package:flutter/widgets.dart';
import 'package:insure_mate/generic_models/policy_model.dart';
import 'package:insure_mate/providers/policy_provider/policy_provider.dart';

class AddPolicyService extends ChangeNotifier {
  final PolicyProvider policyProvider;

  AddPolicyService({required this.policyProvider});

  Future<bool> addPolicy(Policy policy) async {
    return await policyProvider.addPolicy(policy);
  }
}