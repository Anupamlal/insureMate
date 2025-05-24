import 'package:intl/intl.dart';

extension StringExtensions on String {
  String makeEmailAsID() {
    String emailAsID = this.replaceAll(".", ",");
    return emailAsID;
  }

  String todayDate() {
    return DateFormat("dd/MM/yyyy").format(DateTime.now());
  }
}