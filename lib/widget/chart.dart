// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:pennywise/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:pennywise/widget/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      return {
        'Day': DateFormat.E().format(weekDay).substring(0, 1),
        'Amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpend {
    return groupedTransactionValues.fold(
      0.0,
      (sum, element) {
        return sum + (element['Amount'] as double);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['Day'] as String,
                data['Amount'] as double,
                totalSpend == 0.0
                    ? 0.0
                    : (data['Amount'] as double) / totalSpend,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
