import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onListRemoveExpense,
  });
  final List<Expense> expenses;
  final void Function(Expense expense) onListRemoveExpense;

  @override
  Widget build(BuildContext context) {
    // here we will not use Column to output all expenses because the column renders or fetches all the items of list at once. Instead we will use listview here. It gives a bydefault scollable list. If we use Listview with its children property just as column then it will also render all list at once. So solution to this is Listview.builder constructor here the items are created only when they are about tp be visible on the screen.
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        onDismissed: (direction) {
          onListRemoveExpense(expenses[index]);
        },
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        key: ValueKey(expenses[index]),
        child: ExpensesItem(expenses[index]),
      ),
    );
  }
}
