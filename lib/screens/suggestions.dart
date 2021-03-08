import 'package:flutter/material.dart';
import '../providers/suggestion.dart';
import '../widgets/navBar.dart';
import 'suggested.dart';
import 'package:provider/provider.dart';
import '../models/suggestedargs.dart';

class SuggestionsScreen extends StatefulWidget {
  static const String routeName = '/suggestions';

  @override
  _SuggestionsScreenState createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  @override
  void initState() {
    Suggestions regionSuggestions = new Suggestions();
    Suggestions seasonSuggestions = new Suggestions();
    final List<SuggestionTile> regions = [
      SuggestionTile('North', AssetImage('assets/images/north.png'), false),
      SuggestionTile('East', AssetImage('assets/images/east.png'), false),
      SuggestionTile('South', AssetImage('assets/images/south.png'), false),
      SuggestionTile('West', AssetImage('assets/images/west.png'), false),
    ];
    final List<SuggestionTile> seasons = [
      SuggestionTile(
          'Summer', AssetImage('assets/images/weather-sunny.png'), false),
      SuggestionTile(
          'Winter', AssetImage('assets/images/weather-snowy-heavy.png'), false),
      SuggestionTile(
          'Autumn', AssetImage('assets/images/weather-rainy.png'), false),
      SuggestionTile('Spring',
          AssetImage('assets/images/weather-partly-cloudy.png'), false),
    ];
    regionSuggestions.setSuggestions(regions);
    seasonSuggestions.setSuggestions(seasons);
    Provider.of<SuggestionsCategories>(context, listen: false)
        .addCategory(regionSuggestions, 'Regions');
    Provider.of<SuggestionsCategories>(context, listen: false)
        .addCategory(seasonSuggestions, 'Seasons');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                'Where do you want to go in Albania?',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 160,
              child: GridView.count(
                childAspectRatio: 2 / 0.7,
                crossAxisCount: 2,
                children: Provider.of<SuggestionsCategories>(context)
                    .render('Regions'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                'When do you want to visit Albania?',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 160,
              child: GridView.count(
                childAspectRatio: 2 / 0.7,
                crossAxisCount: 2,
                children: Provider.of<SuggestionsCategories>(context)
                    .render('Seasons'),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Text(
                    'Suggest',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.cyan,
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                      SuggestedScreen.routeName,
                      arguments: SuggestedArguments(
                        Provider.of<SuggestionsCategories>(context,
                                listen: false)
                            .season,
                        Provider.of<SuggestionsCategories>(context,
                                listen: false)
                            .region,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarWidget(1),
    );
  }
}
