import 'package:enum_to_string/enum_to_string.dart';

enum Expansion {
  base,
  dominion,
  eons,
  incursion,
  storm,
  alliance,
  conflict,
}

extension ExpansionExtension on Expansion {
  static Expansion convert(String value) {
    if (value == "Base Game") {
      return Expansion.base;
    }
    return (EnumToString.fromString(Expansion.values, value.split(" ")[1]));
  }

  static String getInitials(Expansion expansion) {
    if (expansion == Expansion.base) {
      return "";
    }
    return "C${expansion.toString()[0].toUpperCase()}";
  }
}
