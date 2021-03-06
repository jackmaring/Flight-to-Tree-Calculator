import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sustainibility_project/C02_flight_calculator_plugin/airport.dart';

class AirportsService with ChangeNotifier {
  static Future<List<Airport>> _load(String path) async {
    final data = await rootBundle.loadString(path);
    return data
        .split('\n')
        .map((line) => Airport.fromLine(line))
        .where((airport) => airport != null)
        .toList();
  }

  static Future<List<Airport>> loadAirportsList() async {
    List<Airport> airports = await _load('assets/airports.txt');
    return airports;
  }

  static Airport searchIata(String iata) {
    List<Airport> airports;
    Airport airport = airports.firstWhere((airport) => airport.iata == iata);
    return airport;
  }

  static List<Airport> searchString(String string) {
    List<Airport> airports;
    string = string.toLowerCase();
    final matching = airports.where((airport) {
      final iata = airport.iata ?? '';
      return iata.toLowerCase() == string ||
          airport.name.toLowerCase() == string ||
          airport.city.toLowerCase() == string ||
          airport.country.toLowerCase() == string;
    }).toList();
    // found exact matches
    if (matching.length > 0) {
      return matching;
    }
    // search again with less strict criteria
    return airports.where((airport) {
      final iata = airport.iata ?? '';
      return iata.toLowerCase().contains(string) ||
          airport.name.toLowerCase().contains(string) ||
          airport.city.toLowerCase().contains(string) ||
          airport.country.toLowerCase().contains(string);
    }).toList();
  }
}
