import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insure_mate/theme/app_text_style.dart';
import 'package:intl/intl.dart';

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
    final fupDate = json["fup_date"];
    final String notes = json["notes"];
    final int nextDueDate = json["next_due_date"];
    int? isUploaded = json["is_uploaded"];
    final String? phoneNumber = json["phone_number"];

    int? finalFupDate = null;
    if (fupDate != null) {
      finalFupDate = fupDate;
    }

    final policy = Policy(
      policyholderName,
      policyNo,
      premiumAmount,
      premiumMode,
      startDate,
      finalFupDate,
      notes,
      nextDueDate,
      phoneNumber,
    );
    policy.isUploaded = isUploaded == 1;

    return policy;
  }

  Map<String, dynamic> toJson({bool isForFirebase = false}) {
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
      json['is_uploaded'] = isUploaded ? 1 : 0;
    }

    return json;
  }

  final Map<PremiumMode, int> _frequencyMap = {
    PremiumMode.monthly: 1,
    PremiumMode.quarterly: 3,
    PremiumMode.halfYearly: 6,
    PremiumMode.yearly: 12,
  };

  int getPremiumModeNoOfMonths() {
    return _frequencyMap[premiumMode] ?? 1;
  }

  double premiumAmountValue () => double.parse(premiumAmount);

  String getPolicyDueDate() {
    final premiumDueDate = DateTime.fromMillisecondsSinceEpoch(nextDueDate);
    return DateFormat("dd/MM/yyyy").format(premiumDueDate);
  }

  String getPolicyStartDate() {
    final premiumStartDate = DateTime.fromMillisecondsSinceEpoch(startDate);
    return DateFormat("dd/MM/yyyy").format(premiumStartDate);
  }

  Widget getPolicyDueStatus() {
    final premiumDueDate = DateTime.fromMillisecondsSinceEpoch(nextDueDate);
    final dueStatus = _getDueStatus(premiumDueDate);

    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: dueStatus.color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          child: Text(dueStatus.label, style: AppTextStyle.subTitleSmall.apply(color: Colors.white, fontWeightDelta: 2)),
        ),
      ),
    );
  }

  DueStatus _getDueStatus(DateTime nextPremiumDate) {

    final today = DateTime.now();
    final difference = nextPremiumDate.difference(today).inDays;

    if (difference <= 180) {
      return DueStatus(
        label: 'Lapsed',
        color: Color(0xFFE53935), // Red
        type: DueStatusType.lapsed,
      );
    }else if (difference < 0) {
      return DueStatus(
        label: 'Overdue',
        color: Color(0xFFE53935), // Red
        type: DueStatusType.overdue,
      );
    } else if (difference <= 15) {
      return DueStatus(
        label: 'Upcoming',
        color: Color(0xFFFBC02D), // Amber
        type: DueStatusType.upcoming,
      );
    } else {
      return DueStatus(
        label: 'Not Due',
        color: Color(0xFF43A047), // Green
        type: DueStatusType.notDue,
      );
    }
  }
}

enum DueStatusType { lapsed, overdue, upcoming, notDue }

class DueStatus {
  final String label;
  final Color color;
  final DueStatusType type;

  DueStatus({required this.label, required this.color, required this.type});
}
