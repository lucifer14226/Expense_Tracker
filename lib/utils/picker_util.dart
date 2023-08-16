import 'package:flutter/cupertino.dart';

void showPicker(BuildContext context, Widget child) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) => Container(
      height: 216,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.only(top: 6),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(top: false, child: child),
    ),
  );
}
