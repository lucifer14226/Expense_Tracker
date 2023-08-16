import 'package:fease/model/category.dart';
import 'package:realm/realm.dart';
import 'model/expenses.dart';

var _config = Configuration.local([Expenses.schema, Category.schema],schemaVersion: 2);
var realm = Realm(_config);
