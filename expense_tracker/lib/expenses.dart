import 'package:expense_tracker/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> expenses = [
    Expense(
        amount: 2.50,
        title: 'Flutter Course',
        date: DateTime.now(),
        category: Category.work),
    Expense(
        amount: 21.50,
        title: 'Dinner',
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        amount: 3.30,
        title: 'Coffee',
        date: DateTime.now(),
        category: Category.leisure),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Expenses"),
          SizedBox(
            height: 200, // or any other height you want
            child: ExpenseList(expenses: expenses),
          ),
        ],
      ),
    );
  }
}
