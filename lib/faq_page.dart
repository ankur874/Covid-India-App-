import 'file:///C:/Users/Ankur/AndroidStudioProjects/covid_tracker/lib/data_source.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQS'),
      ),
      body: ListView.builder(
          itemCount: DataSource.questionAnswers.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              initiallyExpanded: false,
              backgroundColor: primaryBlack,
              title: Text(
                DataSource.questionAnswers[index]['question'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Text(
                    DataSource.questionAnswers[index]['answer'],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
