import 'dart:convert';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
import 'package:codex/data/data_model.dart';
import 'package:flutter/services.dart' show rootBundle;

List<Song> parseSongs(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Song>((json) => Song.fromFson(json)).toList();
}

Future<List<Song>> getSongs() {
  // get the users from the search.json file in the assets folder
  // Print debug line to see if the file is loaded
  print('Loading search.json');
  return rootBundle.loadString('assets/search.json').then((jsonStr) {
    return compute(parseSongs, jsonStr);
  });
}