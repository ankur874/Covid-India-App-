import 'dart:convert';

import 'file:///C:/Users/Ankur/AndroidStudioProjects/covid_tracker/lib/data_source.dart';
import 'panels/info_panel.dart';
import 'panels/most_affected_states.dart';
import 'panels/wrold_wide.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'states_data.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worlddata;
  bool downward = true;
  // ignore: non_constant_identifier_names
  String AffectedStatesArrow = "Most";
  IconData arrowSide = Icons.arrow_upward;
  int length;
  String time;
  void fetchWorldData() async {
    var uri = Uri.parse('https://api.covid19india.org/data.json');
    http.Response response = await http.get(uri);
    setState(() {
      worlddata = jsonDecode(response.body);
    });
    length = worlddata['cases_time_series'].length - 1;
    time = worlddata['cases_time_series'][length]['date'];
  }

  @override
  void initState() {
    fetchWorldData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19 TRACKER'),
      ),
      body: ListView(
        children: [
          Container(
            height: 100.0,
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            color: Colors.orange.shade100,
            child: Text(
              DataSource.quote,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                  fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'India',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => StatesPage()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: primaryBlack,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      'Regional',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          worlddata == null
              ? Center(child: CircularProgressIndicator())
              : WorldWidePanel(
                  worlddata: worlddata,
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              time == null ? '' : 'Updated date: $time',
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$AffectedStatesArrow Affected States',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (downward == true) {
                        AffectedStatesArrow = "Least";
                        downward = false;
                        arrowSide = Icons.arrow_downward;
                      } else if (downward == false) {
                        AffectedStatesArrow = "Most";
                        downward = true;
                        arrowSide = Icons.arrow_upward;
                      }
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: primaryBlack,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 12,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    child: Icon(
                      arrowSide,
                      size: 22.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          worlddata == null
              ? Container()
              : MostAffectedPanel(
                  statesData: worlddata,
                  downward: downward,
                ),
          SizedBox(
            height: 20.0,
          ),
          InfoPanel(),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              'WE ARE TOGETHER IN THE FIGHT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
