import 'dart:convert';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
import 'package:codex/data/data_model.dart';
import 'package:flutter/services.dart' show rootBundle;

Map<String, List<Song>> parseSongs(String responseBody) {
  final antwerpse = jsonDecode(responseBody)["antwerpse"].cast<Map<String, dynamic>>();
  final rodexOud = jsonDecode(responseBody)["rodex_oud"].cast<Map<String, dynamic>>();
  final antwerpseParsed = antwerpse.map<Song>((json) => Song.fromFson(json)).toList();
  final rodexOudParsed = rodexOud.map<Song>((json) => Song.fromFson(json)).toList();
  return {"antwerpse": antwerpseParsed, "rodex_oud": rodexOudParsed};
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