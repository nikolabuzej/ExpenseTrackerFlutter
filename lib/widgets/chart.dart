import './chartBar.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactions.fold(0.0, (sum, el) {
      return sum + el['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding:EdgeInsets.all(10),
                child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceAround,
            children: groupedTransactions.map((transaction) {
              return Flexible(
                    fit:FlexFit.tight,
                          child: ChartBar(transaction['day'], transaction['amount'],

                   totalSpending==0?0.0:(transaction['amount'] as double) / totalSpending),
              );
            }).toList(),
          ),
        ),
      );
  
  }
}
