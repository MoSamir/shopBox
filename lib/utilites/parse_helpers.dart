class ParseHelpers {
  static double parseDouble(String? number) {
    if (number == null || number.toLowerCase() == 'null' || number == '')
      return 0.0;
    if (number.contains('.')) {
      return double.parse(number);
    } else {
      return int.parse(number) * 1.0;
    }
  }

  static parseInt(String? number) {
    if(number == null || number == "null")
      return 0;
    else
      return int.parse(number);

  }
}
