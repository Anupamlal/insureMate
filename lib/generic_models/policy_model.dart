import '../helper/app_string.dart';

enum PremiumMode {
  yearly,
  halfYearly,
  quarterly,
  monthly;

  static PremiumMode getFrom(String premiumModeStr) {
    switch (premiumModeStr) {
      case AppString.yearlyText:
        return PremiumMode.yearly;

      case AppString.halfYearlyText:
        return PremiumMode.halfYearly;

      case AppString.quarterlyText:
        return PremiumMode.quarterly;

      case AppString.monthlyText:
        return PremiumMode.monthly;

      default:
        return PremiumMode.yearly;
    }
  }
}

extension PremiumModeExtension on PremiumMode {
  String get rawValue {
    switch (this) {
      case PremiumMode.yearly:
        return AppString.yearlyText;
      case PremiumMode.halfYearly:
        return AppString.halfYearlyText;
      case PremiumMode.quarterly:
        return AppString.quarterlyText;
      case PremiumMode.monthly:
        return AppString.monthlyText;
    }
  }
}

class Policy {
  final String policyholderName;
  final String policyNo;
  final String premiumAmount;
  final PremiumMode premiumMode;
  final int startDate;
  final int? fupDate;
  final String notes;
  final int nextDueDate;
  bool isUploaded = false;
  final String? phoneNumber;

  Policy(
    this.policyholderName,
    this.policyNo,
    this.premiumAmount,
    this.premiumMode,
    this.startDate,
    this.fupDate,
    this.notes,
    this.nextDueDate,
    this.phoneNumber,
  );

  factory Policy.fromJSON(Map<String, dynamic> json) {
    final String policyholderName = json["policyholder_name"];
    final String policyNo = json["policy_no"];
    final String premiumAmount = json["premium_amount"];

    String premiumModeStr = json["premium_mode"];

    final PremiumMode premiumMode = PremiumMode.getFrom(premiumModeStr);
    final int startDate = json["start_date"];
    int? fupDate = json["fup_date"];
    final String notes = json["notes"];
    final int nextDueDate = json["next_due_date"];
    final int isUploaded = json["is_uploaded"];
    final String? phoneNumber = json["phone_number"];

    final policy = Policy(
      policyholderName,
      policyNo,
      premiumAmount,
      premiumMode,
      startDate,
      fupDate,
      notes,
      nextDueDate,
      phoneNumber,
    );
    policy.isUploaded = isUploaded == 1;

    return policy;
  }

  Map<String, dynamic> toJson({bool isForFirebase = false})  {
    var json = {
      'policyholder_name': policyholderName,
      'policy_no': policyNo,
      'premium_amount': premiumAmount,
      'premium_mode': premiumMode.rawValue,
      'start_date': startDate,
      'fup_date': fupDate,
      'notes': notes,
      'next_due_date': nextDueDate,
      'phone_number': phoneNumber,
    };

    if (!isForFirebase) {
      json['is_uploaded'] =  isUploaded ? 1 : 0;
    }

    return json;
  }
}
