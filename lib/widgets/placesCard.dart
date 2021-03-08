import 'package:flutter/material.dart';
import '../providers/places.dart';
import '../screens/sights_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlacesCard extends StatefulWidget {
  final Places places;
  final List<Place> placesInfo;
  PlacesCard(this.places, this.placesInfo);
  @override
  _PlacesCardState createState() => _PlacesCardState();
}

class _PlacesCardState extends State<PlacesCard> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.placesInfo.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (ctx, index) {
        return InkWell(
          child: Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width / 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      height: 180,
                      width: MediaQuery.of(context).size.width / 2.2,
                      image: NetworkImage(widget.placesInfo[index].imageURL),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${widget.placesInfo[index].placeName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.locationArrow,
                              size: 10,
                              color: Colors.white70,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${widget.placesInfo[index].region}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: widget.placesInfo[index].isFavorite
                          ? Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 25,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 25,
                            ),
                      onPressed: () {
                        setState(() {
                          widget.placesInfo[index].toggleFavorite();
                          widget.places.save();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              SightsScreen.routeName,
              arguments: widget.placesInfo[index],
            );
          },
        );
      },
    );
  }
}
