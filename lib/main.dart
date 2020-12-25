import './screens/favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AlbaniaGo/providers/places.dart';
import './screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Places(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AlbaniaGo',
        theme: ThemeData(
          primaryColor: Color(0xFF3EBACE),
          accentColor: Color(0xFFD8ECF1),
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        home: HomeScreen(),
        routes: {
          FavoritesScreen.routeName: (ctx) => FavoritesScreen(),
        },
      ),
    );
  }
}
