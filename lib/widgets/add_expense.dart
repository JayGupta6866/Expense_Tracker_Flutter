import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMMMMd('en_US');

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.onListAddExpense});

  final void Function(Expense expense) onListAddExpense;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  // var expense_title = '';
  // void _inputTitle(String value) {
  //   expense_title = value;
  // }

  final _titleController =
      TextEditingController(); // inbuild tool by flutter to store values of ffields. We need to dispose if after use.

  final _amountController = TextEditingController();
  Category _selectedCategory = Category.stationary;

  DateTime? _selectedDate;

  void _datePickerAppear() async {
    final today = DateTime.now();
    final firstDate = DateTime(2022);
    final pickedDate = await showDatePicker(
      // fluitter will eait for user to register and select the date and then as soon as the value is registered next lines of code woukd be executed.
      context: context,
      initialDate: today,
      firstDate: firstDate,
      lastDate: today,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    // tryParse returns null if entered value is a nonconvertable string e.g "Hello" => NULL but if input is convertable like "2.24" => it will return double value of 2.24 i.e 2.24.
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        invalidAmount ||
        _selectedDate == null) {
      // error message ...
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("OK"))
          ],
          title: const Text("Invalid Input !"),
          content: const Text("Please Enter valid data in the fields !"),
        ),
      );
      return;
    }

    // safe to add an expense,
    widget.onListAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      print(constraints.minWidth);
      print(constraints.maxWidth);
      print(constraints.minHeight);
      print(constraints.maxHeight);
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                TextField(
                  // onChanged: _inputTitle,
                  controller: _titleController,
                  maxLength: 40,
                  decoration: const InputDecoration(
                    label: Text("Title"),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '₹ ',
                          label: Text("Amount"),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selectedDate == null
                            ? "No Date Selected!"
                            : formatter.format(_selectedDate!)),
                        IconButton(
                          onPressed: _datePickerAppear,
                          icon: const Icon(Icons.calendar_month_sharp),
                        )
                      ],
                    ))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map((cat) => DropdownMenuItem(
                                value: cat,
                                child: Text(cat.name.toUpperCase()),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: _submitExpense,
                      child: const Text("Save Expense"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
