import 'dart:collection';

import 'package:cosmodex/models/alert_level.dart';
import 'package:cosmodex/models/expansion.dart';
import 'package:cosmodex/models/phase.dart';
import 'package:cosmodex/models/flare.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/aliens.dart';

class Alien {
  const Alien({
    @required this.name,
    this.image,
    this.expansion,
    this.alert_level,
    this.short_desc,
    this.game_setup,
    this.description,
    this.player,
    this.mandatory,
    this.phases,
    this.lore,
    this.wild,
    this.super_flare,
    this.retooled_gameplay,
    this.edits,
    this.tips,
    this.classic_flare,
  });

  Alien.fromJson(dynamic json, this.image)
      : name = json["name"],
        expansion = ExpansionExtension.convert(json["expansion"]),
        alert_level = EnumToString.fromString(AlertLevel.values, json["color"]),
        short_desc = json["short_desc"],
        game_setup = json["game_setup"],
        description = json["description"],
        player = json["player"],
        mandatory = json["mandatory"],
        phases = PhaseExtension.convertList(json["phases"].cast<String>()),
        lore = json["lore"],
        wild = Flare.fromJson(json["wild"]),
        super_flare = Flare.fromJson(json["super_flare"]),
        retooled_gameplay = json["retooled_gameplay"],
        edits = json["edits"],
        tips = json["tips"] != null ? json["tips"].cast<String>() : [],
        classic_flare = json["classic_flare"] != null
            ? [
                Flare.fromJson(json["classic_flare"]["wild"]),
                Flare.fromJson(json["classic_flare"]["super_flare"])
              ]
            : [];

  final String name;
  final String image;
  final Expansion expansion;
  final AlertLevel alert_level;
  final String short_desc;
  final String game_setup;
  final String description;
  final String player;
  final bool mandatory;
  final List<Phase> phases;
  final String lore;
  final Flare wild;
  final Flare super_flare;
  final String retooled_gameplay;
  final String edits;
  final List<String> tips;
  final List<Flare> classic_flare;

  Color get color => getAlienColor(alert_level);
}

class AlienModel extends ChangeNotifier {
  final List<Alien> _aliens = [];
  int _selectedIndex = 0;

  UnmodifiableListView<Alien> get aliens => UnmodifiableListView(_aliens);

  bool get hasData => _aliens.isNotEmpty;

  Alien get alien => _aliens[_selectedIndex];

  int get index => _selectedIndex;

  static AlienModel of(BuildContext context, {bool listen = false}) =>
      Provider.of<AlienModel>(context, listen: listen);

  void setAliens(List<Alien> aliens) {
    _aliens.clear();
    _aliens.addAll(aliens);

    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;

    notifyListeners();
  }
}
