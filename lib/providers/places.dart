import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Place with ChangeNotifier {
  final String id;
  final String placeName;
  final String description;
  final String season;
  final String imageURL;
  bool isFavorite;

  Place({
    @required this.id,
    @required this.placeName,
    @required this.description,
    @required this.season,
    @required this.imageURL,
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
    var url = 'http://10.0.2.2:3000/places';
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
          season: element['data']['season'],
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
