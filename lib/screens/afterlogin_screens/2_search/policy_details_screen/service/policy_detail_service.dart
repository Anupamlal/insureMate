import 'package:insure_mate/generic_models/policy_model.dart';
import 'package:insure_mate/helper/app_helper.dart';

class PolicyDetailService {
  final Policy policy;
  int _numberOfMissedTerms = 0;
  int _numberOfFirstYearTerms = 0;
  double _totalLateFee = 0;
  double _totalPremiumAmount = 0;

  int totalTermsDue() => _numberOfMissedTerms;
  double totalLateFee() => _totalLateFee;
  double getTotalPremiumAmount() => _totalPremiumAmount;

  PolicyDetailService(this.policy) {
    _setNoOfMissedTerms();
    _calculateTotalLateFee();
    _totalPremiumAmount = policy.premiumAmountValue() * _numberOfMissedTerms;
  }

  double getTotalGSTOnPremium() {
    if (_numberOfFirstYearTerms > 0) {
      int remainingTerms = _numberOfMissedTerms - _numberOfFirstYearTerms;
      return (_numberOfFirstYearTerms *
              policy.premiumAmountValue() *
              AppHelper.premiumGSTRateMap[1]!) +
          (remainingTerms *
              policy.premiumAmountValue() *
              AppHelper.premiumGSTRateMap[2]!);
    }
    return (_totalPremiumAmount * AppHelper.premiumGSTRateMap[2]!).roundToDouble();
  }
  
  double getTotalGSTOnLateFee() {
    return (_totalLateFee * AppHelper.lateFeeGSTRate).roundToDouble();
  }

  void _setNoOfMissedTerms() {
    int missedTerms = 0;
    final premiumStartDate = DateTime.fromMillisecondsSinceEpoch(
      policy.startDate,
    );

    DateTime termDate = DateTime.fromMillisecondsSinceEpoch(policy.nextDueDate);
    int termMonths = policy.getPremiumModeNoOfMonths();

    // Keep adding terms until the next due date is after paymentDate
    while (termDate.isBefore(DateTime.now())) {
      missedTerms += 1;
      termDate = DateTime(
        termDate.year,
        termDate.month + termMonths,
        termDate.day,
      );

      bool withinFirstYear = termDate.isBefore(
        premiumStartDate.add(Duration(days: 365)),
      );

      if (withinFirstYear) {
        _numberOfFirstYearTerms++;
      }
    }

    _numberOfMissedTerms = missedTerms;
  }

  void _calculateTotalLateFee() {
    final premiumDueDate = DateTime.fromMillisecondsSinceEpoch(
      policy.nextDueDate,
    );
    final paymentDate = DateTime.now();
    final premium = policy.premiumAmountValue();

    int termMonths = policy.getPremiumModeNoOfMonths();
    const double monthlyRate = 0.00792;

    DateTime termDueDate = premiumDueDate;
    double totalLateFee = 0.0;

    while (termDueDate.isBefore(paymentDate)) {
      int delayedMonths =
          (paymentDate.year - termDueDate.year) * 12 +
          (paymentDate.month - termDueDate.month);

      if (paymentDate.day < termDueDate.day) delayedMonths--;

      delayedMonths = delayedMonths < 0 ? 0 : delayedMonths;

      double lateFee = premium * monthlyRate * delayedMonths;
      totalLateFee += lateFee;

      termDueDate = DateTime(
        termDueDate.year,
        termDueDate.month + termMonths,
        termDueDate.day,
      );
    }

    _totalLateFee = double.parse("${totalLateFee.round()}");
  }

  double getTotalPaidAmount() {
    return _totalPremiumAmount + getTotalGSTOnPremium() + _totalLateFee + getTotalGSTOnLateFee();
  }


}
