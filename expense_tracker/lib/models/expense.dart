import 'package:uuid/uuid.dart';

final uuid = Uuid();

// Create an enum for category
enum Category { food, travel, leisure, work }

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  @override
  String toString() {
    return 'Expense(title: $title, amount: $amount, date: $date, category: $category)';
  }
}
