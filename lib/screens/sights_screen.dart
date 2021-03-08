import 'package:AlbaniaGo/providers/places.dart';
import 'package:flutter/material.dart';
import '../providers/sights.dart';
import 'package:provider/provider.dart';
import '../widgets/navBar.dart';
import '../widgets/sightsWidget.dart';

class SightsScreen extends StatefulWidget {
  static const routeName = '/sights';

  @override
  _SightsScreenState createState() => _SightsScreenState();
}

class _SightsScreenState extends State<SightsScreen> {
  bool _isInit = false;
  bool _isLoading = false;
  Place currentPlace;

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
    if (_isLoading) {
      currentPlace = ModalRoute.of(context).settings.arguments;
      return Provider.of<PlaceSights>(context, listen: false)
          .fetchSights(currentPlace.id)
          .then(
            (value) => setState(() {
              _isLoading = false;
            }),
          );
    } else
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
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => _reload(context, true),
              child: SightsWidget(
                  Provider.of<PlaceSights>(context).sights, currentPlace),
            ),
      bottomNavigationBar: NavigationBarWidget(0),
    );
  }
}
