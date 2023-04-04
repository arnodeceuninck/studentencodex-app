import 'dart:convert';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
import 'package:codex/data/data_model.dart';
import 'package:flutter/services.dart' show rootBundle;

Map<String, List<Song>> parseSongs(String responseBody) {
  final antwerpse = jsonDecode(responseBody)["antwerpse"].cast<Map<String, dynamic>>();
  final rodex_oud = jsonDecode(responseBody)["rodex_oud"].cast<Map<String, dynamic>>();
  final antwerpse_parsed = antwerpse.map<Song>((json) => Song.fromFson(json)).toList();
  final rodex_oud_parsed = rodex_oud.map<Song>((json) => Song.fromFson(json)).toList();
  return {"antwerpse": antwerpse_parsed, "rodex_oud": rodex_oud_parsed};
}

Future<List<Book>> getBooks() {
  return rootBundle.loadString('assets/codices.json').then((jsonStr) {
    return [Book("Antwerpse Codex", "antwerpse"), Book("Rodex Oud", "rodex_oud")];
  });

}

Future<Map<String, List<Song>>> getSongs() {
  // get the users from the codices.json file in the assets folder
  // Print debug line to see if the file is loaded
  print('Loading codices.json');
  return rootBundle.loadString('assets/codices.json').then((jsonStr) {
    return compute(parseSongs, jsonStr);
  });
}