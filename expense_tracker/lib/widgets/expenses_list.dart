import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  State<StatefulWidget> createState() {
    return _ExpenseListState();
  }
}

class _ExpenseListState extends State<ExpenseList> {
  List<Expense> get expenses => widget.expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(expenses[index].id.toString()),
          direction: DismissDirection.startToEnd,
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirm Deletion"),
                  content: Text(
                      'Are you sure you want to delete expense: ${expenses[index].title}?'),
                  actions: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child: const Text("Delete"),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                );
              },
            );
          },
          onDismissed: (direction) {
            var removed;
            setState(() {
              removed = expenses.removeAt(index);
            });
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 3),
                backgroundColor: Colors.green,
                content: Text('Expense ${removed.title} deleted!'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () => setState(() {
                    expenses.insert(index, removed);
                  }),
                  textColor: Colors.white,
                ),
              ),
            );
          },
          background: Container(
            color: Theme.of(context).colorScheme.errorContainer,
          ),
          child: ExpenseItem(expenses[index]),
        );
      },
    );
  }
}
