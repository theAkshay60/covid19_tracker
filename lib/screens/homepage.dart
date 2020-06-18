import 'dart:convert';
import 'package:covid19tracker/constants.dart';
import 'package:covid19tracker/pages/country_page.dart';
import 'package:covid19tracker/panels/info_panel.dart';
import 'package:covid19tracker/panels/most_affected_countries.dart';
import 'package:covid19tracker/panels/worldwide_panel.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldWideData() async {
    var response = await http.get('https://corona.lmao.ninja/v2/all');
    if (response.statusCode == 200) {
      setState(() {
        worldData = json.decode(response.body);
      });
    }
  }

  List countryData;
  fetchCountriesData() async {
    var response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    if (response.statusCode == 200) {
      setState(() {
        countryData = json.decode(response.body);
      });
    }
  }

  Future completeData() async {
    fetchWorldWideData();
    fetchCountriesData();
  }

  @override
  void initState() {
    completeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.lightbulb_outline
                  : Icons.highlight),
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light);
              })
        ],
        centerTitle: false,
        title: Text(
          'COVID-19 TRACKER',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: completeData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                height: 100,
                color: Colors.orange[100],
                child: Text(
                  Constants.quote,
                  style: TextStyle(
                    color: Colors.orange[800],
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Worldwide',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountryPage()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: primaryBlack,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          'Regional',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              worldData == null
                  ? Center(child: CircularProgressIndicator())
                  : WorldWidePanel(
                      worldData: worldData,
                    ),
              worldData == null?Container(): PieChart(
                dataMap: {
                  'Confirmed': worldData['cases'].toDouble(),
                  'Active': worldData['active'].toDouble(),
                  'Recovered': worldData['recovered'].toDouble(),
                  'Deaths': worldData['deaths'].toDouble(),
                },
                colorList: [
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.grey[500],
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Most affected Countries',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              countryData == null
                  ? Container()
                  : MostAffectedPanel(
                      countryData: countryData,
                    ),
              InfoPanel(),
              SizedBox(
                height: 20.0,
              ),
              Center(
                  child: Text(
                'WE ARE TOGETHER IN THE FIGHT',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
