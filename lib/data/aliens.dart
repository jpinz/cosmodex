import 'dart:convert' as json;

import 'package:flutter/material.dart';

import '../configs/AppColors.dart';
import '../models/alien.dart';
import 'package:flutter/services.dart' show rootBundle;

// Parses all the aliens
Future<List<Alien>> getAliensList(BuildContext context) async {
  final manifestContent =
      await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

  final Map<String, dynamic> manifestMap = json.jsonDecode(manifestContent);
  final alienPaths = manifestMap.keys
      .where((String key) => key.contains('assets/aliens/'))
      .where((String key) => key.contains('.json'))
      .toList();

  Future<List<Alien>> aliens =
      Future.wait(alienPaths.map((alienPath) => loadAlien(alienPath)).toList())
          .then((List<Alien> values) => values);

  return aliens;
}

Future<Alien> loadAlien(String path) async {
  return Alien.fromJson(json.jsonDecode(await rootBundle.loadString(path)),
      path.replaceAll(".json", ".jpg"));
}

// A function to get Color for the alien
Color getAlienColor(String color) {
  switch (color.toLowerCase()) {
    case 'red':
      return AppColors.red;
    case 'yellow':
      return AppColors.yellow;
    case 'green':
      return AppColors.green;
    default:
      return AppColors.green;
  }
}
