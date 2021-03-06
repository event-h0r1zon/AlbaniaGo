import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Sight {
  final String name;
  final String description;
  final String info;
  final String imageURL;
  Sight(
    this.name,
    this.description,
    this.info,
    this.imageURL,
  );
}

class PlaceSights with ChangeNotifier {
  List<Sight> _sights = [];
  List<Sight> get sights {
    return [..._sights];
  }

  Future<void> fetchSights(String placeID) async {
    var url = 'http://10.0.2.2:3000/places/$placeID/sights';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body);
      List<Sight> loadedSights = [];
      final extractedData = data['data'] as List<dynamic>;
      extractedData.forEach((element) {
        loadedSights.add(
          new Sight(
            element['data']['sight'],
            element['data']['description'],
            element['data']['info'],
            element['data']['imageURL'],
          ),
        );
      });
      _sights = loadedSights;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
