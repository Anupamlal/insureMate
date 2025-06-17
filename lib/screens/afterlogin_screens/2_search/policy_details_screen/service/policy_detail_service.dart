import 'package:insure_mate/generic_models/policy_model.dart';
import 'package:insure_mate/helper/app_helper.dart';

class PolicyDetailService {
  final Policy policy;
  int _numberOfMissedTerms = 0;
  int _numberOfFirstYearTerms = 0;
  int _numberOfSecondYearTerms = 0;
  int _numberOfThirdYearTerms = 0;
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
      return ((_numberOfFirstYearTerms *
                  policy.premiumAmountValue() *
                  AppHelper.premiumGSTRateMap[1]!) +
              (remainingTerms *
                  policy.premiumAmountValue() *
                  AppHelper.premiumGSTRateMap[2]!))
          .roundToDouble();
    }
    return (_totalPremiumAmount * AppHelper.premiumGSTRateMap[2]!)
        .roundToDouble();
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
      } else if (termDate.isBefore(
        premiumStartDate.add(Duration(days: 365 * 2)),
      )) {
        _numberOfSecondYearTerms++;
      } else if (termDate.isBefore(
        premiumStartDate.add(Duration(days: 365 * 3)),
      )) {
        _numberOfThirdYearTerms++;
      }

    }

    _numberOfMissedTerms = missedTerms;
  }

  void _calculateTotalLateFee() {
    final premiumDueDate = DateTime.fromMillisecondsSinceEpoch(
      policy.nextDueDate,
    );
    final paymentDate = DateTime.now();

    if (paymentDate.year == premiumDueDate.year && (paymentDate.month - premiumDueDate.month <= 1)){
      _totalLateFee = 0;
      return;
    }

    final premium = policy.premiumAmountValue();

    int termMonths = policy.getPremiumModeNoOfMonths();
    double monthlyRate = AppHelper.lateFeeRate;

    DateTime termDueDate = premiumDueDate;
    double totalLateFee = 0.0;

    while (termDueDate.isBefore(paymentDate)) {
      int delayedMonths =
          (paymentDate.year - termDueDate.year) * 12 +
          (paymentDate.month - termDueDate.month);

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
    return _totalPremiumAmount +
        getTotalGSTOnPremium() +
        _totalLateFee +
        getTotalGSTOnLateFee();
  }

  double getExpectedCommission() {
    double firstYearCommissionRate = AppHelper.agentCommissionRate[1]!;
    double secondYearCommissionRate = AppHelper.agentCommissionRate[2]!;
    double thirdYearCommissionRate = AppHelper.agentCommissionRate[3]!;
    double remainingYearCommissionRate = AppHelper.agentCommissionRate[4]!;

    return double.parse((policy.premiumAmountValue() *
        (firstYearCommissionRate * _numberOfFirstYearTerms +
            secondYearCommissionRate * _numberOfSecondYearTerms +
            thirdYearCommissionRate * _numberOfThirdYearTerms +
            remainingYearCommissionRate *
                (_numberOfMissedTerms -
                    (_numberOfFirstYearTerms +
                        _numberOfSecondYearTerms +
                        _numberOfThirdYearTerms)))).toStringAsFixed(2));
  }
}
