//import 'dart:html';

import 'file:///C:/Users/Ankur/AndroidStudioProjects/covid_tracker/lib/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StatesPage extends StatefulWidget {
  @override
  _StatesPageState createState() => _StatesPageState();
}

class _StatesPageState extends State<StatesPage> {
  Map indiaData;
  List stateList;
  void fetchWorldData() async {
    var uri = Uri.parse('https://api.covid19india.org/data.json');
    http.Response response = await http.get(uri);
    setState(() {
      indiaData = jsonDecode(response.body);
    });
    stateList = indiaData['statewise'];
    stateList.removeAt(0);
    stateList.removeLast();
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
        title: Text('STATES DATA'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: Search(stateList));
              }),
        ],
      ),
      body: indiaData == null
          ? (Center(
              child: CircularProgressIndicator(),
            ))
          : ListView.builder(
              itemBuilder: (context, index) {
                //index++;
                return Container(
                  height: 130,
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 75,
                        width: 125,
                        //margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(
                          child: Text(
                            stateList[index]['state'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'CONFIRMED: ' +
                                      stateList[index]['confirmed'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      color: Colors.red),
                                ),
                                Text(
                                  ' (+${stateList[index]['deltaconfirmed'].toString()})',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                      color: Colors.red.shade600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'ACTIVE: ' +
                                      (int.parse(stateList[index]
                                                  ['confirmed']) -
                                              int.parse(stateList[index]
                                                  ['recovered']) -
                                              int.parse(
                                                  stateList[index]['deaths']))
                                          .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      color: Colors.blue),
                                ),
                                Text(
                                  ' (+${(int.parse(stateList[index]['deltaconfirmed']) - int.parse(stateList[index]['deltarecovered']) - int.parse(stateList[index]['deltadeaths'])).toString()})',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                      color: Colors.blue),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'RECOVERED: ' +
                                      stateList[index]['recovered'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      color: Colors.green),
                                ),
                                Text(
                                  ' (+${stateList[index]['deltarecovered'].toString()})',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'DEATHS: ' +
                                      stateList[index]['deaths'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      color: Colors.grey.shade800),
                                ),
                                Text(
                                  ' (+${stateList[index]['deltadeaths'].toString()})',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                      color: Colors.grey.shade800),
                                ),
                              ],
                            ),
                            Text(
                              'Last Updated time: ${stateList[index]['lastupdatedtime']}',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: indiaData == null ? 0 : stateList.length,
            ),
    );
  }
}
