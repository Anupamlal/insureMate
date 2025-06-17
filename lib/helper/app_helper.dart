class AppHelper {
  static final rupee = "₹";
  static final double lateFeeRate = 9.5/1200;
  static final lateFeeGSTRate = 0.18;
  static final Map<int, double> premiumGSTRateMap = {
    1: .045,
    2: .0225
  };

  static final Map<int, double> agentCommissionRate = {
    1: .25,
    2: .075,
    3: .075,
    4: .05
  };
}
