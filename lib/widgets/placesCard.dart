import 'package:flutter/material.dart';
import '../providers/places.dart';

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
        return Container(
          margin: EdgeInsets.all(10),
          width: 210,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    height: 180,
                    width: 180,
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
                      Text(
                        '${widget.placesInfo[index].region}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
        );
      },
    );
  }
}
