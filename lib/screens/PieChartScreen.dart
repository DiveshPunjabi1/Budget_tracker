

// try and error solving
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartScreen extends StatelessWidget {
  final String userId;

  PieChartScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker Pie Chart'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('transactions')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No transactions available'));
          }

          List<Map<String, dynamic>> transactions =
              snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return {
              'category': data['category'],
              'amount': data['amount'].toDouble(), // Convert int to double
            };
          }).toList();

          return Center(
            child: PieChart(
              PieChartData(
                sections: transactions.map((transaction) {
                  return PieChartSectionData(
                    value: transaction['amount'],
                    title: transaction['category'],
                    color: getRandomColor(),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Color getRandomColor() {
    // Generate random color for pie chart sections
    return Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1,
    );
  }
}
