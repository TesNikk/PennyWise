// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '৳${transactions[index].amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
