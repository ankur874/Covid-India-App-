import 'package:flutter/material.dart';

class WorldWidePanel extends StatelessWidget {
  final Map worlddata;
  const WorldWidePanel({Key key, this.worlddata}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int length = worlddata['cases_time_series'].length - 1;
    int active = int.parse(
            worlddata['cases_time_series'][length]['totalconfirmed']) -
        int.parse(worlddata['cases_time_series'][length]['totalrecovered']) -
        int.parse(worlddata['cases_time_series'][length]['totaldeceased']);
    int dailyActive = int.parse(
            worlddata['cases_time_series'][length]['dailyconfirmed']) -
        int.parse(worlddata['cases_time_series'][length]['dailyrecovered']) -
        int.parse(worlddata['cases_time_series'][length]['dailydeceased']);
    if (dailyActive < 0) {
      dailyActive = dailyActive * -1;
    }
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: [
          statusPanel(
            panelColor: Colors.red.shade100,
            title: 'CONFIRMED',
            count: worlddata['cases_time_series'][length]['totalconfirmed']
                .toString(),
            textColor: Colors.red,
            todayInc: worlddata['cases_time_series'][length]['dailyconfirmed']
                .toString(),
          ),
          statusPanel(
            panelColor: Colors.blue.shade100,
            title: 'ACTIVE',
            count: active.toString(),
            textColor: Colors.blue.shade900,
            todayInc: dailyActive.toString(),
          ),
          statusPanel(
            panelColor: Colors.green.shade100,
            title: 'RECOVERED',
            count: worlddata['cases_time_series'][length]['totalrecovered']
                .toString(),
            textColor: Colors.green,
            todayInc: worlddata['cases_time_series'][length]['dailyrecovered']
                .toString(),
          ),
          statusPanel(
            panelColor: Colors.grey.shade400,
            title: 'DEATHS',
            count: worlddata['cases_time_series'][length]['totaldeceased']
                .toString(),
            textColor: Colors.grey.shade900,
            todayInc: worlddata['cases_time_series'][length]['dailydeceased']
                .toString(),
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class statusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;
  final String todayInc;

  const statusPanel(
      {Key key,
      this.panelColor,
      this.textColor,
      this.title,
      this.count,
      this.todayInc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: panelColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 10,
          )
        ],
      ),
      height: 80.0,
      width: width / 2,
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16.0, color: textColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '(+$todayInc)',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
