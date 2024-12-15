import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  @override
  Widget build(BuildContext context) {
    return (const AboutDialog(
      applicationIcon: Icon(Icons.abc_sharp),
      applicationName: 'Expense Tracker',
    ));
  }
}
