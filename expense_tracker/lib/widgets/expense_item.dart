import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getColor(expense.category),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            Text(
              expense.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text('${_formatCategory(expense.category)} - '),
                Text(
                    '£${expense.amount.toStringAsFixed(2)} on ${expense.date.day}/${expense.date.month}/${expense.date.year}'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getColor(Category category) {
    switch (category) {
      case Category.work:
        return Colors.blue;
      case Category.leisure:
        return Colors.amber;
      case Category.travel:
        return Colors.purple;
      case Category.food:
        return Colors.red;
    }
  }

  String _formatCategory(Category category) {
    switch (category) {
      case Category.work:
        return 'Work';
      case Category.leisure:
        return 'Leisure';
      case Category.travel:
        return 'Travel';
      case Category.food:
        return 'Food';
    }
  }
}
