import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataProvider with ChangeNotifier {
  List<Expense> _data = [];

  List<Expense> get data => _data;

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://4fc459004004408ea1b76eb36bdc8bed.api.mockbin.io/'),
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body) as List<dynamic>;
      _data = jsonList.map((json) => Expense.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
