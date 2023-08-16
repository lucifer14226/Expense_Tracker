import 'dart:async';

import 'package:fease/components/expense_list.dart';
import 'package:fease/extension/expense_extension.dart';
import 'package:fease/model/expenses.dart';
import 'package:fease/realm.dart';
import 'package:fease/type/period.dart';
import 'package:fease/type/widget.dart';
import 'package:fease/utils/picker_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:realm/realm.dart';

class Expense extends WidgetWithTitle {
  const Expense({super.key}) : super(title: "EXPENSES");

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  int _selectedPeriodIndex = 1;
  Period get _selectedPeriod => periods[_selectedPeriodIndex];

  var realmExpenses = realm.all<Expenses>();
  StreamSubscription<RealmResultsChanges<Expenses>>? _expenseSub;
  List<Expenses> _expenses = [];

  // double get _total => _expenses.map((expense) => expense.amount);

  @override
  void initState() {
    _expenses = realmExpenses.toList().filterByPeriod(_selectedPeriod, 0)[0];
    super.initState();
  }

  @override
  void dispose() async{
 
    await _expenseSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text("Expense")),
      child: SafeArea(
        bottom: true,
        right: true,
        left: true,
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Total for :"),
                CupertinoButton(
                  child: Text(getPeriodDisplayName(_selectedPeriod)),
                  onPressed: () => showPicker(
                    context,
                    CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: _selectedPeriodIndex),
                      magnification: 1,
                      squeeze: 1.2,
                      useMagnifier: false,
                      itemExtent: 32,
                      onSelectedItemChanged: (int selectedIndex) {
                        setState(
                          () {
                            _selectedPeriodIndex = selectedIndex;
                            _expenses = realmExpenses.toList().filterByPeriod(
                                periods[_selectedPeriodIndex], 0)[0];
                          },
                        );
                      },
                      children: List.generate(
                        periods.length,
                        (index) {
                          return Center(
                            child: Text(getPeriodDisplayName(periods[index])),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 4, 4, 0),
                  child: const Text("\$"),
                ),
                const Text("")
              ],
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.fromLTRB(12, 16, 12, 0),
              child: ExpenseList(expenses: _expenses),
            ))
          ],
        ),
      ),
    );
  }
}
