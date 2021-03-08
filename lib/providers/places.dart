import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Place with ChangeNotifier {
  final String id;
  final String placeName;
  final String description;
  final Map<String, dynamic> season;
  final String imageURL;
  final String region;
  bool isFavorite;

  Place({
    @required this.id,
    @required this.placeName,
    @required this.description,
    @required this.season,
    @required this.imageURL,
    @required this.region,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

class Places with ChangeNotifier {
  List<Place> _places = [];
  List<Place> get places {
    return [..._places];
  }

  Future<void> fetchPlaces() async {
    const url = 'http://192.168.1.5:3000/places';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body);
      List<Place> loadedPlaces = [];
      final extractedData = data['data'] as List<dynamic>;
      extractedData.forEach((element) {
        loadedPlaces.add(new Place(
          id: element['ref']['@ref']['id'],
          placeName: element['data']['name'],
          description: element['data']['description'],
          season: element['data']['seasons'],
          region: element['data']['region'],
          imageURL: element['data']['imageURL'],
        ));
      });
      _places = loadedPlaces;
      read();
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  List<Place> favoritePlaces() {
    return _places.where((place) => place.isFavorite).toList();
  }

  List<Place> suggestedPlaces(String season, String region) {
    return _places
        .where((place) => (place.season[season] && place.region == region))
        .toList();
  }

  Future<void> read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoritesData =
        json.decode(prefs.getString('Favorites List')) as Map<String, dynamic>;
    _places.forEach((place) {
      if (favoritesData[place.placeName] != null)
        place.isFavorite = favoritesData[place.placeName];
    });
    notifyListeners();
  }

  Future<void> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, bool> favoritesData = {};
    _places.forEach((place) {
      favoritesData[place.placeName] = place.isFavorite;
    });
    final savedData = json.encode(favoritesData);
    prefs.setString('Favorites List', savedData);
  }
}
