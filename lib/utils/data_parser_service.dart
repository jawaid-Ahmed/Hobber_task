class DataParserService {
  int getInt(dynamic number) {
    if (number != null && number != "") {
      if (number is String) {
        return int.tryParse(number) ?? 0;
      } else if (number is bool) {
        return number ? 1 : 0;
      }

      return number;
    }

    return 0;
  }

  double getDouble(dynamic number) {
    return (number == null || number == "") ? 0.0 : double.parse('$number');
  }

  bool getBool(dynamic d) {
    if (d is String) {
      return (d == 'true' || d == '1') ? true : false;
    } else if (d is int) {
      return d == 1 ? true : false;
    } else if (d is bool) {
      return d;
    }
    return false;
  }

  String getString(dynamic string) {
    return (string != null) ? "$string" : "";
  }

  List<dynamic> getDynamicList(_data) {
    return (_data is List<dynamic>) ? _data : [];
  }

  Map<dynamic, dynamic> getDynamicMap(_data) {
    return (_data is Map<dynamic, dynamic>) ? _data : {};
  }

  Map<dynamic, dynamic> getStringDynamicMap(Map<String, dynamic> _data) {
    return (_data is Map<String, dynamic>) ? _data : {};
  }

  Map<String, dynamic> getMap(Map<dynamic, dynamic> _data) {
    return (_data is Map<String, dynamic>) ? _data : {};
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}

DataParserService dataParser = DataParserService();
