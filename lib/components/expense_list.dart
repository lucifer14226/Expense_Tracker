import 'package:fease/components/day_expense.dart';
import 'package:fease/extension/date_extension.dart';
import 'package:fease/model/expenses.dart';
import 'package:flutter/cupertino.dart';

class ExpenseList extends StatelessWidget {
  final List<Expenses> expenses;
  const ExpenseList({super.key,  required this.expenses});

  Map<DateTime, List<Expenses>> _computeExpense(List<Expenses> expenses) {
    Map<DateTime, List<Expenses>> group = {};
    for (final Expenses expense in expenses) {
      DateTime date = expense.date.simpleDate;
      if (group.containsKey(date)) {
        group[date]!.add(expense);
      } else {
        group[date] = [expense];
      }
    }
    return Map.fromEntries(
        group.entries.toList()..sort((el1, el2) => el2.key.compareTo(el1.key)));
  }

  @override
  Widget build(BuildContext context) {
    var displayExpense = _computeExpense(expenses);
    return CupertinoScrollbar(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: displayExpense.length,
        itemBuilder: (context, index) {
          final DateTime date = displayExpense.keys.elementAt(index);
          final List<Expenses> dayExpense = displayExpense[date]!;
          if (dayExpense.isEmpty) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text('No Expense for the period'),
            );
          }
          return DayExpenses(date: date, expenses: expenses);
        },
      ),
    );
  }
}
