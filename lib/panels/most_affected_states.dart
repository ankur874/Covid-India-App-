import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MostAffectedPanel extends StatelessWidget {
  final Map statesData;
  final downward;
  const MostAffectedPanel({Key key, this.statesData, this.downward})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    List mostaffectedlist = statesData['statewise'];
    if (downward == true) {
      mostaffectedlist.sort(
          (b, a) => int.parse(a['active']).compareTo(int.parse(b['active'])));
    } else if (downward == false) {
      mostaffectedlist.sort(
          (a, b) => int.parse(a['active']).compareTo(int.parse(b['active'])));
    }

    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          index++;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Text(
                  index.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                SizedBox(
                  width: 225,
                  height: 25,
                  child: Text(
                    mostaffectedlist[index]['state'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Active:' + mostaffectedlist[index]['active'].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
