import 'package:cosmodex/logic/data/flare_type.dart';
import 'package:cosmodex/logic/data/phases_type.dart';
import 'package:cosmodex/logic/data/player_type.dart';
import 'package:equatable/equatable.dart';
import 'package:cosmodex/logic/data/alien_type.dart';

class FlareData extends Equatable {
  const FlareData({
    required this.type,
    required this.alienType,
    required this.expansion,
    required this.phase,
    required this.description,
  });

  final FlareType type;
  final AlienType alienType;
  final PlayerType expansion;
  final PhasesType phase;
  final String description;

  @override
  List<Object?> get props => [type, alienType, description];
}
