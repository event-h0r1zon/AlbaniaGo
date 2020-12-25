import 'package:AlbaniaGo/widgets/placesCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/places.dart';
import '../widgets/navBar.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favorites';
  @override
  Widget build(BuildContext context) {
    final places = Provider.of<Places>(context);
    return Scaffold(
      body: PlacesCard(places, places.favoritePlaces()),
      bottomNavigationBar: NavigationBarWidget(2),
    );
  }
}
