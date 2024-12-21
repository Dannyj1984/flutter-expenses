import 'dart:math';

import 'package:expense_tracker/providers/data.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  Category? _selectedCategory;
  late List<Expense> _value;

  var _filteredExpenses = <Expense>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dataProvider = Provider.of<DataProvider>(context);
    _value = dataProvider.data;
    _sortedExpenses = [..._value];
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return const NewExpense();
        });
  }

  Expense _newExpense() {
    return Expense(
        title: 'New Expense',
        amount: _randomAmount(),
        date: DateTime.now(),
        category: _randomCategory());
  }

  double _randomAmount() {
    return Random().nextDouble() * 100;
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

  Row _filterOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: DropdownButton<Category>(
            value: _selectedCategory,
            iconSize: 24,
            isExpanded: true,
            isDense: true,
            hint: const Text('Select'),
            onChanged: (Category? newValue) {
              setState(() {
                _selectedCategory = newValue;
                _filteredExpenses = _value
                    .where((element) => element.category == _selectedCategory)
                    .toList();
              });
            },
            items: [
              const DropdownMenuItem<Category>(
                value: null,
                child: Text('Select All'),
              ),
              ...Category.values
                  .map<DropdownMenuItem<Category>>((Category category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.name),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
        title: const Text('Expenses'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buttons(),
          const SizedBox(height: 20),
          _filterOptions(),
          const SizedBox(height: 20),
          Expanded(
            child: ExpenseList(
                expenses: _filteredExpenses.isNotEmpty
                    ? _filteredExpenses
                    : _sortedExpenses),
          ),
        ],
      ),
    );
  }
}
