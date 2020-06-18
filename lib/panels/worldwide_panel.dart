import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorldWidePanel extends StatelessWidget {

  final Map worldData;

  const WorldWidePanel({Key key, this.worldData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio:
            2.0, //this means that the width of widget in the grid will be twice the height of widget.
      ),
      children: <Widget>[
        StatusPanel(
          title: 'CONFIRMED',
          panelColor: Colors.red[100],
          textColor: Colors.red,
          count: worldData['cases'].toString(),
        ),
        StatusPanel(title: 'ACTIVE',
          panelColor: Colors.blue[100],
          textColor: Colors.blue[900],
          count: worldData['active'].toString(),),
        StatusPanel(title: 'RECOVERED',
          panelColor: Colors.green[100],
          textColor: Colors.green,
          count: worldData['recovered'].toString(),),
        StatusPanel(title: 'DEATHS',
          panelColor: Colors.grey[400],
          textColor: Colors.grey[900],
          count: worldData['deaths'].toString(),),
      ],
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  StatusPanel({this.panelColor, this.textColor, this.title, this.count});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(10.0),
      color: panelColor,
      height: 80.0,
      width: width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            count,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
