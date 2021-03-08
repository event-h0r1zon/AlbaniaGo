import 'package:flutter/material.dart';
import '../providers/sights.dart';
import '../providers/places.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SightsWidget extends StatefulWidget {
  final Place currentPlace;
  final List<Sight> sights;
  SightsWidget(this.sights, this.currentPlace);
  @override
  _SightsWidgetState createState() => _SightsWidgetState();
}

class _SightsWidgetState extends State<SightsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image.network(
                  widget.currentPlace.imageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 30),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 25,
                color: Colors.black,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${widget.currentPlace.placeName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.locationArrow,
                        size: 13,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${widget.currentPlace.region}',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: IconButton(
                icon: widget.currentPlace.isFavorite
                    ? Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 32,
                      )
                    : Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 32,
                      ),
                onPressed: () {
                  setState(() {
                    widget.currentPlace.toggleFavorite();
                    Provider.of<Places>(context, listen: false).save();
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
            itemCount: widget.sights.length,
            itemBuilder: (BuildContext context, int index) {
              if (index > 0)
                return SightListTile(widget.sights[index]);
              else
                return Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      margin:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      child: Text(
                        "About",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.currentPlace.description,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      child: Text(
                        "Explore",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    SightListTile(widget.sights[index]),
                  ],
                );
            },
          ),
        ),
      ],
    );
  }
}

class SightListTile extends StatelessWidget {
  final Sight sight;
  SightListTile(this.sight);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
          height: 170.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 220,
                  child: Text(
                    sight.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  sight.description,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          top: 15.0,
          bottom: 15.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              width: 110.0,
              image: NetworkImage(sight.imageURL),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
