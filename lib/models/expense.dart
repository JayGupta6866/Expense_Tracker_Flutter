import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid(); // package to generate the unique ID

final formatter =
    DateFormat.yMMMMd('en_US'); // intl package to format date in ymd format.

enum Category {
  food,
  stationary,
  rent,
  luxury,
  travel
} // this has only five possible values as provided in the braces. This works similar to string but not is a string.

const categoryIcon = {
  Category.food: Icons.restaurant_menu_sharp,
  Category.stationary: Icons.book_sharp,
  Category.rent: Icons.house_sharp,
  Category.travel: Icons.flight_sharp,
  Category.luxury: Icons.movie_sharp
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); // here v4 method creates the unique IDs.

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    // this is a getter method. We can also use normal method instead of this method.
    return formatter.format(date);
  }
}

class BucketExpenses {
  const BucketExpenses({required this.category, required this.expenses});

  BucketExpenses.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }

    return sum;
  }
}
