import 'package:flutter/material.dart';
import '../screens/favorites.dart';

class NavigationBarWidget extends StatefulWidget {
  final int _currentTab;
  NavigationBarWidget(this._currentTab);
  @override
  _NavigationBarWidgetState createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget._currentTab,
      onTap: (int value) {
        setState(() {
          switch (value) {
            case 0:
              if (widget._currentTab != value)
                Navigator.of(context).pushReplacementNamed('/');
              break;
            case 1:
              break;
            case 2:
              if (widget._currentTab != value)
                Navigator.of(context)
                    .pushReplacementNamed(FavoritesScreen.routeName);
              break;
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 25,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.dynamic_feed,
            size: 25,
          ),
          label: 'Suggestions',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            size: 25,
          ),
          label: 'Favorites',
        ),
      ],
    );
  }
}
