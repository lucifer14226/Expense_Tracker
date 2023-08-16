import 'package:fease/components/expense_row.dart';
import 'package:fease/extension/date_extension.dart';
import 'package:fease/extension/expense_extension.dart';
import 'package:fease/extension/number_extension.dart';
import 'package:fease/model/expenses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayExpenses extends StatelessWidget {
  final DateTime date;
  final List<Expenses> expenses;
  const DayExpenses({super.key, required this.date, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date.formatedDate,
            style: const TextStyle(
                color: CupertinoColors.inactiveGray,
                fontWeight: FontWeight.w500),
          ),
          const Divider(
            thickness: 2,
            color: CupertinoColors.darkBackgroundGray,
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: expenses
                .map((expense) => Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: ExpenseRow(expense: expense),
                    ))
                .toList(),
          ),
          const Divider(
            thickness: 2,
            color: CupertinoColors.darkBackgroundGray,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Expanded(
                child: Text(
                  'Total',
                  style: TextStyle(color: CupertinoColors.inactiveGray),
                ),
              ),
              Text(
                'USD${expenses.sum().removeDecimalZeroFormat()}',
                style: const TextStyle(
                    color: CupertinoColors.inactiveGray,
                    fontWeight: FontWeight.w500),
              )
            ],
          )
        ],
      ),
    );
  }
}
