import 'package:enum_to_string/enum_to_string.dart';

enum Phase {
  startTurn,
  regroup,
  destiny,
  launch,
  alliance,
  planning,
  reveal,
  resolution,
  anyPhase
}

extension PhaseExtension on Phase {
  static Phase convert(String value) {
    return (EnumToString.fromString(Phase.values, value, camelCase: true));
  }

  static List<Phase> convertList(List<String> values) {
    List<Phase> results = <Phase>[];
    for (var value in values) {
      results
          .add(EnumToString.fromString(Phase.values, value, camelCase: true));
    }
    return results;
  }
}
