import 'package:AlbaniaGo/providers/suggestion.dart';
import 'screens/suggested.dart';
import './screens/favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AlbaniaGo/providers/places.dart';
import './screens/home.dart';
import './screens/suggestions.dart';
import './providers/sights.dart';
import './screens/sights_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Places(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => SuggestionsCategories(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PlaceSights(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AlbaniaGo',
        theme: ThemeData(
          primaryColor: Color(0xFF3EBACE),
          accentColor: Colors.cyan,
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        home: HomeScreen(),
        routes: {
          FavoritesScreen.routeName: (ctx) => FavoritesScreen(),
          SuggestionsScreen.routeName: (ctx) => SuggestionsScreen(),
          SuggestedScreen.routeName: (ctx) => SuggestedScreen(),
          SightsScreen.routeName: (ctx) => SightsScreen(),
        },
      ),
    );
  }
}
