import 'package:flutter/material.dart';
import '../widgets/navBar.dart';
import 'package:provider/provider.dart';
import '../providers/places.dart';
import '../widgets/placesCard.dart';
import '../models/suggestedargs.dart';

class SuggestedScreen extends StatelessWidget {
  static const routeName = '/suggestions/suggested';
  @override
  Widget build(BuildContext context) {
    final places = Provider.of<Places>(context);
    final SuggestedArguments arguments =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Suggestions',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),*/
      body: PlacesCard(
        places,
        places.suggestedPlaces(arguments.season, arguments.region),
      ),
      bottomNavigationBar: NavigationBarWidget(1),
    );
  }
}
