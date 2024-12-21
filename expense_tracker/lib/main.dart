import 'package:expense_tracker/providers/data.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataProvider()..fetchData(),
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const Expenses(),
      ),
    ),
  );
}
