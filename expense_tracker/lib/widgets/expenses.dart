import 'dart:math';

import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

enum Filter { date, title, category }

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  List<Expense> _sortedExpenses = [];
  bool _filterDate = true;
  bool _filterTitle = true;
  bool _filterCategory = true;
  Filter _selectedFilter = Filter.date;
  final List<Expense> expenses = [
    Expense(
        amount: 2.50,
        title: 'Flutter Course',
        date: DateTime.parse('2024-12-01'),
        category: Category.work),
    Expense(
        amount: 21.50,
        title: 'Dinner',
        date: DateTime.parse('2024-12-04'),
        category: Category.leisure),
    Expense(
        amount: 3.30,
        title: 'Coffee',
        date: DateTime.parse('2024-12-07'),
        category: Category.travel),
    Expense(
        amount: 3.30,
        title: 'Coffee',
        date: DateTime.parse('2024-12-07'),
        category: Category.leisure),
    Expense(
        amount: 3.30,
        title: 'Coffee',
        date: DateTime.parse('2024-12-07'),
        category: Category.leisure),
    Expense(
        amount: 3.30,
        title: 'Coffee',
        date: DateTime.parse('2024-12-07'),
        category: Category.leisure),
    Expense(
        amount: 3.30,
        title: 'Coffee',
        date: DateTime.parse('2024-12-07'),
        category: Category.leisure),
  ];

  @override
  void initState() {
    super.initState();
    _sortedExpenses = [...expenses];
  }

  Expense _newExpense() {
    return Expense(
        title: 'New Expense',
        amount: _randomAmount(),
        date: DateTime.now(),
        category: _randomCategory());
  }

  double _randomAmount() {
    return Random().nextDouble() * 1000;
  }

  Category _randomCategory() {
    return Category.values[Random().nextInt(Category.values.length)];
  }

  Row _buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: _selectedFilter == Filter.date
                  ? Colors.blue
                  : Colors.transparent,
              foregroundColor: _selectedFilter == Filter.date
                  ? Colors.grey.shade400
                  : const Color.fromARGB(255, 147, 70, 161)),
          onPressed: () {
            setState(() {
              if (_filterDate) {
                _sortedExpenses.sort((a, b) => -a.date.compareTo(b.date));
                _filterDate = false;
                _selectedFilter = Filter.date;
              } else {
                _sortedExpenses.sort((a, b) => a.date.compareTo(b.date));
                _filterDate = true;
                _selectedFilter = Filter.date;
              }
            });
          },
          child: Row(children: [
            const Text('Date'),
            _selectedFilter == Filter.date
                ? (_filterDate
                    ? const Icon(
                        Icons.arrow_upward,
                        size: 16,
                      )
                    : const Icon(
                        Icons.arrow_downward,
                        size: 16,
                      ))
                : Container(),
          ]),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: _selectedFilter == Filter.title
                  ? Colors.blue
                  : Colors.transparent,
              foregroundColor: _selectedFilter == Filter.title
                  ? Colors.grey.shade400
                  : const Color.fromARGB(255, 147, 70, 161)),
          onPressed: () {
            setState(() {
              if (_filterTitle) {
                _sortedExpenses.sort((a, b) => -a.title.compareTo(b.title));
                _filterTitle = false;
                _selectedFilter = Filter.title;
              } else {
                _sortedExpenses.sort((a, b) => a.title.compareTo(b.title));
                _filterTitle = true;
                _selectedFilter = Filter.title;
              }
            });
          },
          child: Row(
            children: [
              const Text('Title'),
              _selectedFilter == Filter.title
                  ? (_filterTitle
                      ? const Icon(
                          Icons.arrow_upward,
                          size: 16,
                        )
                      : const Icon(
                          Icons.arrow_downward,
                          size: 16,
                        ))
                  : Container(),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: _selectedFilter == Filter.category
                  ? Colors.blue
                  : Colors.transparent,
              foregroundColor: _selectedFilter == Filter.category
                  ? Colors.grey.shade400
                  : const Color.fromARGB(255, 147, 70, 161)),
          onPressed: () {
            setState(() {
              if (_filterCategory) {
                _sortedExpenses.sort((a, b) =>
                    -a.category.toString().compareTo(b.category.toString()));
                _filterCategory = false;
                _selectedFilter = Filter.category;
              } else {
                _sortedExpenses.sort((a, b) =>
                    a.category.toString().compareTo(b.category.toString()));
                _filterCategory = true;
                _selectedFilter = Filter.category;
              }
            });
          },
          child: Row(
            children: [
              const Text('Category'),
              _selectedFilter == Filter.category
                  ? (_filterCategory
                      ? const Icon(
                          Icons.arrow_upward,
                          size: 16,
                        )
                      : const Icon(
                          Icons.arrow_downward,
                          size: 16,
                        ))
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  Row _addButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                _sortedExpenses.add(_newExpense());
              });
            },
            child: const Text("Add"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 200, child: Text("Expenses")),
          _buttons(),
          _addButton(),
          Expanded(
            child: ExpenseList(expenses: _sortedExpenses),
          ),
        ],
      ),
    );
  }
}
