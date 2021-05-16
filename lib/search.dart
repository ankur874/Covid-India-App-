import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final List stateList;
  Search(this.stateList);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestionList = query.isEmpty
        ? stateList
        : stateList
            .where(
                (element) => element['state'].toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
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
                    suggestionList[index]['state'],
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
                              suggestionList[index]['confirmed'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.red),
                        ),
                        Text(
                          ' (+${suggestionList[index]['deltaconfirmed'].toString()})',
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
                              (int.parse(suggestionList[index]['confirmed']) -
                                      int.parse(
                                          suggestionList[index]['recovered']) -
                                      int.parse(
                                          suggestionList[index]['deaths']))
                                  .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.blue),
                        ),
                        Text(
                          ' (+${(int.parse(suggestionList[index]['deltaconfirmed']) - int.parse(suggestionList[index]['deltarecovered']) - int.parse(suggestionList[index]['deltadeaths'])).toString()})',
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
                              suggestionList[index]['recovered'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.green),
                        ),
                        Text(
                          ' (+${suggestionList[index]['deltarecovered'].toString()})',
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
                              suggestionList[index]['deaths'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.grey.shade800),
                        ),
                        Text(
                          ' (+${suggestionList[index]['deltadeaths'].toString()})',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                    Text(
                      'Last Updated time: ${suggestionList[index]['lastupdatedtime']}',
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
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? stateList
        : stateList
            .where(
                (element) => element['state'].toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
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
                    suggestionList[index]['state'],
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
                              suggestionList[index]['confirmed'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.red),
                        ),
                        Text(
                          ' (+${suggestionList[index]['deltaconfirmed'].toString()})',
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
                              (int.parse(suggestionList[index]['confirmed']) -
                                      int.parse(
                                          suggestionList[index]['recovered']) -
                                      int.parse(
                                          suggestionList[index]['deaths']))
                                  .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.blue),
                        ),
                        Text(
                          ' (+${(int.parse(suggestionList[index]['deltaconfirmed']) - int.parse(suggestionList[index]['deltarecovered']) - int.parse(suggestionList[index]['deltadeaths'])).toString()})',
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
                              suggestionList[index]['recovered'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.green),
                        ),
                        Text(
                          ' (+${suggestionList[index]['deltarecovered'].toString()})',
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
                              suggestionList[index]['deaths'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.grey.shade800),
                        ),
                        Text(
                          ' (+${suggestionList[index]['deltadeaths'].toString()})',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                    Text(
                      'Last Updated time: ${suggestionList[index]['lastupdatedtime']}',
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
      itemCount: suggestionList.length,
    );
  }
}
