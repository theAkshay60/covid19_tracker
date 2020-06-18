import 'dart:convert';
import 'package:covid19tracker/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;
  fetchCountriesData() async {
    var response = await http.get('https://corona.lmao.ninja/v2/countries');
    if(response.statusCode == 200){
      setState(() {
        countryData = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    fetchCountriesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Stats'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: countryData == null ? null : Search(countryData));
            },
          )
        ],
      ),
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : countryList(),
    );
  }

  Widget countryList() {
    return ListView.builder(
        itemCount: countryData == null ? 0 : countryData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
            child: Card(
              elevation: 5.0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                height: 120,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            countryData[index]['country'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Image.network(
                            countryData[index]['countryInfo']['flag'],
                            height: 50.0,
                            width: 60.0,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'CONFIRMED: ${countryData[index]['cases']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                            Text(
                              'ACTIVE: ${countryData[index]['active']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.blue),
                            ),
                            Text(
                              'RECOVERED: ${countryData[index]['recovered']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.green),
                            ),
                            Text(
                              'DEATHS: ${countryData[index]['deaths']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness == Brightness.dark?Colors.grey[100]: Colors.grey[900]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
