import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuggestionTile with ChangeNotifier {
  final String text;
  final AssetImage icon;
  bool active;
  SuggestionTile(this.text, this.icon, this.active);

  void toggleActivation() {
    active = !active;
    notifyListeners();
  }
}

class Suggestions with ChangeNotifier {
  List<SuggestionTile> _suggestions = [];
  List<SuggestionTile> get suggestions {
    return [..._suggestions];
  }

  void setSuggestions(List<SuggestionTile> suggestions) {
    _suggestions = suggestions;
  }
}

class SuggestionsCategories with ChangeNotifier {
  Map<String, Suggestions> _suggestionsCategories = {};
  Map<String, Suggestions> get suggestionsCategories {
    return {..._suggestionsCategories};
  }

  var _season;
  var _region;
  get season {
    return _season;
  }

  get region {
    return _region;
  }

  void addCategory(Suggestions category, String name) {
    _suggestionsCategories[name] = category;
  }

  void deactive(SuggestionTile active, String name) {
    _suggestionsCategories[name].suggestions.forEach((suggestion) {
      if (suggestion != active) suggestion.active = false;
      notifyListeners();
    });
  }

  List<Widget> render(String name) {
    int i = 0;
    Suggestions suggestions = suggestionsCategories[name];
    List<SuggestionTiles> tiles = [];
    suggestions.suggestions.forEach((suggestion) {
      tiles.add(SuggestionTiles(name, i));
      i++;
    });
    return tiles;
  }
}

class SuggestionTiles extends StatefulWidget {
  final String name;
  final int index;
  SuggestionTiles(this.name, this.index);
  @override
  _SuggestionTilesState createState() => _SuggestionTilesState();
}

class _SuggestionTilesState extends State<SuggestionTiles> {
  @override
  Widget build(BuildContext context) {
    List<SuggestionTile> suggestions =
        Provider.of<SuggestionsCategories>(context, listen: false)
            .suggestionsCategories[widget.name]
            .suggestions;
    return Container(
      height: 40,
      width: 180,
      margin: EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            suggestions[widget.index].text,
            style: TextStyle(color: Colors.cyan),
          ),
          tileColor: suggestions[widget.index].active
              ? Color(0xFFebfeff)
              : Colors.white,
          onTap: () {
            setState(() {
              switch (widget.name) {
                case "Seasons":
                  Provider.of<SuggestionsCategories>(context, listen: false)
                      ._season = suggestions[widget.index].text;
                  break;
                case "Regions":
                  Provider.of<SuggestionsCategories>(context, listen: false)
                      ._region = suggestions[widget.index].text;
                  break;
              }
              Provider.of<SuggestionsCategories>(context, listen: false)
                  .deactive(suggestions[widget.index], widget.name);
              suggestions[widget.index].toggleActivation();
            });
          },
          leading: ImageIcon(
            suggestions[widget.index].icon,
          ),
        ),
      ),
    );
  }
}
