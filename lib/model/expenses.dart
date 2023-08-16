import 'package:fease/model/category.dart';
import 'package:intl/intl.dart';
import 'package:realm/realm.dart';

import '../type/recurrence.dart';

part 'expense.g.dart';

@RealmModel()
class $Expense {
  @PrimaryKey()
  late final ObjectId id;
  late final double amount;
  late final $Category? category;
  late final String? note;
  late final DateTime date;
  late final String? recurrence = Recurrence.none;

  get dayInMonth {
    return date.month;
  }

  get dayInWeek {
    DateFormat format = DateFormat("EEEE");
    return format.format(date);
  }

  get month {
    DateFormat format = DateFormat("MMM");
    return format.format(date);
  }

  get year {
    return date.year;
  }
}
