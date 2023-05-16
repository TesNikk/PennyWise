// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:pennywise/widget/transaction_list.dart';
import './widget/new_transactionList.dart';
import 'package:intl/intl.dart';
import 'models/transaction.dart';

void main() => runApp(
      MaterialApp(
        title: 'PennyWise',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.purple[100],
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: TextStyle(
                  fontFamily: 'Opensans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
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
    Transaction(
        id: 'T1', title: 'New Shoes', amount: 500.0, date: DateTime.now()),
    Transaction(
        id: 'T2',
        title: 'Weekly Groceries',
        amount: 700.0,
        date: DateTime.now()),
  ];
  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
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
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.pink,
                elevation: 5.0,
                child: Text('Chart'),
              ),
            ),
            TransactionList(_usertransactions),
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
