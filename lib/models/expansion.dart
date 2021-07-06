import 'package:enum_to_string/enum_to_string.dart';

enum Expansion {
  base,
  dominion,
  eons,
  incursion,
  storm,
  alliance,
  conflict,
  promo,
  anniversary
}

extension ExpansionExtension on Expansion {
  static Expansion convert(String value) {
    if (value == "Base Game") {
      return Expansion.base;
    }
    if (value == "Escape Velocity promo") {
      return Expansion.promo;
    }
    if (value == "42nd Anniversary edition") {
      return Expansion.anniversary;
    }
    return (EnumToString.fromString(Expansion.values, value.split(" ")[1]));
  }

  static String getInitials(Expansion expansion) {
    if (expansion == Expansion.base) {
      return "";
    }
    if (expansion == Expansion.promo) {
      return "PR";
    }
    if (expansion == Expansion.anniversary) {
      return "42";
    }
    return "C${EnumToString.convertToString(expansion)[0].toUpperCase()}";
  }
}
