import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});

  // final myColor =  Color.fromARGB(255, 10, 42, 53);
  // 37, 150, 190
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 18,
              ),
                // color: Color.fromARGB(255, 10, 42, 53),
              
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  "₹ ${expense.amount.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                const Spacer(), // this widget allots all the maximum black space it could to a row or a column.
                Row(
                  children: [
                    Icon(categoryIcon[expense.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      expense.formattedDate,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
