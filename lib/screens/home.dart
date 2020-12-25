import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/places.dart';
import '../widgets/placesCard.dart';
import '../widgets/navBar.dart';

/*
  TO-DO:
  - Add AppBar
  - Add multiple screens such as:
    - Sights Screen
    - Suggestion Screen
    - Favorites Screen (DONE)
  - Work on Refresh Indicator (DONE)
*/

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = false;
  bool _isLoading = false;

  @override
  void initState() {
    _isInit = true;
    super.initState();
  }

  Future<void> _reload(BuildContext context, bool reloading) {
    if (_isInit || reloading)
      setState(() {
        _isLoading = true;
      });
    if (_isLoading)
      return Provider.of<Places>(context, listen: false).fetchPlaces().then(
            (value) => setState(() {
              _isLoading = false;
            }),
          );
    else
      return null;
  }

  @override
  void didChangeDependencies() {
    _reload(context, false);

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final places = Provider.of<Places>(context);
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => _reload(context, true),
              child: PlacesCard(places, places.places),
            ),
      bottomNavigationBar: NavigationBarWidget(0),
    );
  }
}
