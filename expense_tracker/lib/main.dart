import 'package:expense_tracker/providers/data.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';
import 'package:provider/provider.dart';

var kColourScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataProvider()..fetchData(),
      child: MaterialApp(
        theme: ThemeData().copyWith(
            colorScheme: kColourScheme,
            appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: kColourScheme.onPrimaryContainer,
                foregroundColor: kColourScheme.primaryContainer),
            cardTheme: const CardTheme().copyWith(
              color: kColourScheme.primaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: kColourScheme.primaryContainer,
              ),
            ),
            textTheme: ThemeData().textTheme.copyWith(
                    titleLarge: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ))),
        home: const Expenses(),
      ),
    ),
  );
}
