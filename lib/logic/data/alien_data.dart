import 'package:cosmodex/logic/data/expansion_type.dart';
import 'package:cosmodex/logic/data/flare_data.dart';
import 'package:cosmodex/logic/data/level_type.dart';
import 'package:cosmodex/logic/data/phases_type.dart';
import 'package:equatable/equatable.dart';
import 'package:cosmodex/logic/data/alien_type.dart';

class AlienData extends Equatable {
  const AlienData({
    required this.name,
    required this.expansion,
    required this.color,
    required this.shortDesc,
    required this.gameSetup,
    required this.description,
    required this.player,
    required this.mandatory,
    required this.phases,
    required this.lore,
    required this.wild,
    required this.superFlare,
    this.retooledGameplay,
    this.edits,
    this.tips,
    this.classicFlare,
  });

  final AlienType name;
  final ExpansionType expansion;
  final LevelType color;
  final String shortDesc;
  final String gameSetup;
  final String description;
  final String player;
  final bool mandatory;
  final List<PhasesType> phases;
  final String lore;
  final FlareData wild;
  final FlareData superFlare;
  final String? retooledGameplay;
  final String? edits;
  final String? tips;
  final FlareData? classicFlare;

  @override
  List<Object?> get props => [name, expansion, color];
}
