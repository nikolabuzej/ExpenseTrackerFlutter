import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class AddNewtransaction extends StatefulWidget {
  final Function addNewTransaction;
  AddNewtransaction(this.addNewTransaction);

  @override
  _AddNewtransactionState createState() => _AddNewtransactionState();
}

class _AddNewtransactionState extends State<AddNewtransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime datePicked;
  void transactionHandler() {
    final amount = double.parse(amountController.text);
    final title = titleController.text;
    if (amount <= 0 || title.isEmpty) return;
    final newOne = Transaction(
        amount: amount,
        title: title,
        id: DateTime.now().toString(),
        date: datePicked);
    widget.addNewTransaction(newOne);
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        datePicked = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                // onChanged: (value)=>title=value,
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => transactionHandler(),
                // onChanged: (value)=>amount=value,
                controller: amountController,
              ),
              Container(
                height: 100,
                child: Row(
                  children: <Widget>[
                    Text(
                      datePicked == null
                          ? 'Choose a date'
                          : DateFormat.yMd().format(datePicked),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    FlatButton(
                      child: Text('Choose date'),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).accentColor,
                onPressed: transactionHandler,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
