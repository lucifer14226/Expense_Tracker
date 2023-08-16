import 'package:flutter/cupertino.dart';
import 'package:realm/realm.dart';

part 'category.g.dart';

@RealmModel()
class $Category {
  @PrimaryKey()
  late final String name;
  late final int colorValue;

  // String get nameofCategory {
  //   return name;
  // }

  // set name(String name) {
  //   this.name = name;
  // }

  Color get color {
    return Color(colorValue);
  }

  set color(Color color) {
    colorValue = color.value;
  }
}
