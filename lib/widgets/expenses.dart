import 'package:expense_tracker/widgets/add_expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(
        title: 'Party at restaurant.',
        amount: 2000,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Book for Data Structure.',
        amount: 600,
        date: DateTime.now(),
        category: Category.stationary),
    Expense(
        title: 'Rent of Hostel.',
        amount: 2200,
        date: DateTime.now(),
        category: Category.rent),
  ];

  void _addExpense() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddExpense(onListAddExpense: _listAddExpense),
    );
  }

  void _listAddExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _listRemoveExpense(Expense expense) {
    final expenseIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Deleted Successfully!"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _registeredExpense.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // build method is re-executed once we rotate the device.
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text("No Expenses recorded. Start adding some !"),
    );

    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpense,
        onListRemoveExpense: _listRemoveExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Expense Manager"), actions: [
        IconButton(
          onPressed: _addExpense,
          icon: const Icon(Icons.add),
        )
      ]),
      body: (width < 600) ? Column (
        children: [
          Chart(expenses: _registeredExpense),
          Expanded(
            child: mainContent,
          ),
        ],
      )
      : Row(
        children: [
          Expanded(child: Chart(expenses: _registeredExpense)),
          Expanded(
            child: mainContent,
          ),
        ],
      )
    );
  }
}
