class AppHelper {
  static final monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static final rupee = "₹";
  static final lateFeeRate = 0.00792;
  static final lateFeeGSTRate = 0.18;
  static final Map<int, double> premiumGSTRateMap = {
    1: .045,
    2: .0225
  };
}
