import 'dart:async';

import 'package:fease/model/category.dart';
import 'package:fease/model/expenses.dart';
import 'package:fease/realm.dart';
import 'package:fease/type/recurrence.dart';
import 'package:fease/type/widget.dart';
import 'package:fease/utils/picker_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:realm/realm.dart';

var recurrences = List.from(Recurrence.value);

class ExpenseAdd extends WidgetWithTitle {
  const ExpenseAdd({super.key}) : super(title: "ADD ");

  @override
  State<ExpenseAdd> createState() => _ExpenseAddState();
}

class _ExpenseAddState extends State<ExpenseAdd> {
  @override
  Widget build(BuildContext context) {
    return const AddContent();
  }
}

class AddContent extends StatefulWidget {
  const AddContent({super.key});

  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  late final TextEditingController _amountController;
  late final TextEditingController _noteController;
  var realmCategories = realm.all<Category>();
  StreamSubscription<RealmResultsChanges<Category>>? _categoriesSub;

  List<Category> categories = [];
  int _selectRecurrenceIndex = 0;
  int _selectCategoryIndex = 0;
  DateTime _selectDateTime = DateTime.now();
  bool canSubmit = false;

  @override
  void initState() {
    _amountController = TextEditingController();
    _noteController = TextEditingController();
    categories = realmCategories.toList();
    canSubmit = categories.isNotEmpty && _amountController.text.isNotEmpty;
    super.initState();
  }

  @override
  void dispose() async {
    await _categoriesSub?.cancel();
    super.dispose();
  }

  void submitExpense() {
    realm.write(() => realm.add<Expenses>(
          Expenses(ObjectId(), double.parse(_amountController.value.text),
              _selectDateTime,
              category: categories[_selectCategoryIndex],
              note: _noteController.value.text.isNotEmpty
                  ? _noteController.value.text
                  : "none",
              recurrence: recurrences[_selectRecurrenceIndex]),
        ));
    setState(() {
      _amountController.clear();
      _noteController.clear();
      _selectCategoryIndex = 0;
      _selectCategoryIndex = 0;
      _selectDateTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    _categoriesSub ??= realmCategories.changes.listen(
      (event) {
        categories = event.results.toList();
      },
    );
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        middle: Text("Add"),
      ),
      child: SafeArea(
        bottom: true,
        left: true,
        right: true,
        top: true,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          transformAlignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: DecoratedBox(
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  CupertinoFormSection.insetGrouped(
                    children: [
                      DecoratedBox(
                        decoration: const BoxDecoration(),
                        child: CupertinoFormRow(
                          prefix: const Text("Amount",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                          helper: null,
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                          child: CupertinoTextField.borderless(
                            placeholder: "Amount",
                            controller: _amountController,
                            onChanged: (value) {
                              setState(()=> 
                                canSubmit =
                                    categories.isNotEmpty && value.isNotEmpty
                              );
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            textAlign: TextAlign.end,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              backgroundColor: Color.fromARGB(0, 0, 0, 0),
                            ),
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: const BoxDecoration(),
                        child: CupertinoFormRow(
                          prefix: const Text("Recurrence"),
                          helper: null,
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                          child: CupertinoButton(
                            child: Text(recurrences[_selectRecurrenceIndex]),
                            onPressed: () => showPicker(
                              context,
                              CupertinoPicker(
                                scrollController: FixedExtentScrollController(
                                    initialItem: _selectRecurrenceIndex),
                                squeeze: 1.2,
                                magnification: 1,
                                useMagnifier: false,
                                itemExtent: 32,
                                onSelectedItemChanged: (int selectedItem) {
                                  setState(() {
                                    _selectRecurrenceIndex = selectedItem;
                                  });
                                },
                                children: List<Widget>.generate(
                                  recurrences.length,
                                  (index) => Center(
                                    child: Text(recurrences[index]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: const BoxDecoration(),
                        child: CupertinoFormRow(
                            prefix: const Text("Date"),
                            helper: null,
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            child: CupertinoButton(
                              child: Text(
                                  '${_selectDateTime.month}/${_selectDateTime.day}/${_selectDateTime.year} ${_selectDateTime.hour}:${_selectDateTime.minute}'),
                              onPressed: () =>
                                  showPicker(context, CupertinoDatePicker(
                                onDateTimeChanged: (DateTime newDate) {
                                  setState(() {
                                    _selectDateTime = newDate;
                                  });
                                },
                              )),
                            )),
                      ),
                      DecoratedBox(
                        decoration: const BoxDecoration(),
                        child: CupertinoFormRow(
                            prefix: const Text("Catgeory"),
                            helper: null,
                            padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                            child: CupertinoButton(
                              child: Text(categories.isEmpty
                                  ? 'Create Category first'
                                  : categories[_selectCategoryIndex].name,
                                  style: TextStyle(color: categories.isEmpty? CupertinoColors.white:categories[_selectCategoryIndex].color),),
                              onPressed: () => showPicker(
                                  context,
                                  CupertinoPicker(
                                      magnification: 1,
                                      squeeze: 1.2,
                                      useMagnifier: false,
                                      itemExtent: 32,
                                      onSelectedItemChanged: (int value) {
                                        setState(() {
                                          _selectCategoryIndex = value;
                                        });
                                      },
                                      children: List.generate(
                                          categories.length,
                                          (int index) => Container(
                                                width: 12,
                                                height: 12,
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 8, 0),
                                                decoration: BoxDecoration(
                                                    color:
                                                        categories[index].color,
                                                    shape: BoxShape.circle),
                                                child: Text(
                                                    categories[index].name),
                                              )))),
                            )),
                      ),
                      DecoratedBox(
                        decoration: const BoxDecoration(),
                        child: CupertinoFormRow(
                          prefix: const Text("Note"),
                          helper: null,
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                          child: CupertinoTextField.borderless(
                            placeholder: "Note",
                            controller: _noteController,
                            onChanged: (value) {
                              setState(() {
                                canSubmit =
                                    categories.isNotEmpty && value.isNotEmpty;
                              });
                            },
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.end,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              backgroundColor: Color.fromARGB(0, 0, 0, 0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 32),
                    child: CupertinoButton(
                        onPressed: canSubmit ? submitExpense : null,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 13),
                        pressedOpacity: 0.7,
                        borderRadius: BorderRadius.circular(10),
                        color: CupertinoTheme.of(context).primaryColor,
                        disabledColor: CupertinoTheme.of(context)
                            .primaryColor
                            .withAlpha(100),
                        child: Text(
                          "Submit Expense",
                          style: TextStyle(
                              color: canSubmit
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : const Color.fromARGB(100, 255, 255, 255),
                              fontWeight: FontWeight.w500),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
