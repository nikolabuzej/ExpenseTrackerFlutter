// import './models/transaction.dart';
import 'package:flutter/services.dart';

import './widgets/chart.dart';

import './widgets/AddNewTransaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() { 
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(BullshitFlutterMakesMeDo());
}
class BullshitFlutterMakesMeDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.lime,
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _transactions = [
    Transaction(amount: 20.00, title: 'Shoes', id: '12', date: DateTime.now()),
    Transaction(amount: 30.00, title: 'Ram', id: '13', date: DateTime.now())
  ];
  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 15),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(Transaction newTransaction) {
    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          child: AddNewtransaction(_addNewTransaction),
          onTap: () {},
        );
      },
    );
  }

  void _delete(String id) {
    setState(() {
      _transactions.removeWhere((transaction) {
        return transaction.id == id;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final  appBar=AppBar(
        title: Text('Expense Tracker'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],);

    return Scaffold(
      appBar:appBar,    
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
            height:(MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
            child: Chart(_recentTransactions)),
            //  AddNewtransaction(_addNewTransaction),
            Container(
              height:(MediaQuery.of(context).size.height-appBar.preferredSize.height-
              MediaQuery.of(context).padding.top)*0.7,
              child: TransactionList(
                transactions: _transactions,
                delete: _delete,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
