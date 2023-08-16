// import 'package:fease/model/category.dart';
// import 'package:fease/model/expenses_model.dart';
// import 'package:fease/type/recurrence.dart';
// import 'package:realm/realm.dart';

part of 'expenses.dart';

class Expenses extends $Expense with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultSet = false;

  Expenses(ObjectId id, double amount, DateTime date,
      {  Category? category,String? recurrence = Recurrence.none,
      String? note}) {
    if (!_defaultSet) {
      _defaultSet = RealmObjectBase.setDefaults<Expenses>(
          {'recurrence': Recurrence.none});
    }
    RealmObjectBase.set(this, "id", id);
    RealmObjectBase.set(this, "amount", amount);
    RealmObjectBase.set(this, "category", category);
    RealmObjectBase.set(this, "date", date);
    RealmObjectBase.set(this, "note", note);
    RealmObjectBase.set(this, "recurrence", recurrence);
  }
  Expenses._();

  @override
  ObjectId get id => RealmObjectBase.get(this, 'id') as ObjectId;

  @override
  double get amount => RealmObjectBase.get(this, 'amount') as double;

  @override
  Category? get category =>
      RealmObjectBase.get<Category>(this, 'category') as Category?;

  @override
  set category(covariant Category? value) => throw RealmUnsupportedSetError();

  @override
  DateTime get date => RealmObjectBase.get(this, 'date') as DateTime;

  @override
  String? get note => RealmObjectBase.get(this, 'note') as String;

  @override
  String? get recurrence => RealmObjectBase.get(this, 'recurrence') as String;

  @override
  set note(String? value) => throw RealmUnsupportedSetError();

  @override
  set date(DateTime value) => throw RealmUnsupportedSetError();

  @override
  set amount(double value) => throw RealmUnsupportedSetError();

  set recurrence(String? value) => throw RealmUnsupportedSetError();

  @override
  Expenses freeze() => RealmObjectBase.freezeObject<Expenses>(this);

  static SchemaObject get schema => _schema ?? initSchema();
  static SchemaObject? _schema;
  static initSchema() {
    RealmObjectBase.registerFactory(Expenses._);
    return const SchemaObject(ObjectType.realmObject, Expenses, 'Expense', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('note', RealmPropertyType.string, optional: true),
      SchemaProperty('recurrence', RealmPropertyType.string, optional: true),
      SchemaProperty('amount', RealmPropertyType.double, optional: true),
      SchemaProperty('date', RealmPropertyType.timestamp),
      SchemaProperty('category', RealmPropertyType.object,
          linkTarget: 'Category', optional: true),
    ]);
  }
}
