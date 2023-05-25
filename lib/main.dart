// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pennywise/widget/chart.dart';
import 'package:pennywise/widget/transaction_list.dart';
import './widget/new_transactionList.dart';
import 'package:intl/intl.dart';
import 'models/transaction.dart';
import './widget/chart.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(
      MaterialApp(
        title: 'PennyWise',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.purple[100],
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Opensans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: MyHomePage(),
      ),
    );

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _usertransactions = [
  ];
  List<Transaction> get _recentTransaction {
    return _usertransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      id: Uuid().v4(),
      title: title,
      amount: amount,
      date: chosenDate,
    );
    setState(() {
      _usertransactions.add(newTx);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Container(
          height: 700,
          child: GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransactionList(_addNewTransaction),
          ),
        );
      },
    );
  }

  void _removeTransaction(String id) {
    setState(() {
    _usertransactions.removeWhere((element) => element.id==id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        //centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _startNewTransaction(context),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransaction),
            TransactionList(_usertransactions,_removeTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
