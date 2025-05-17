extension StringExtensions on String {
  String makeEmailAsID() {
    String emailAsID = this.replaceAll(".", ",");
    return emailAsID;
  }
}