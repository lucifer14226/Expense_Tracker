import 'package:fease/pages/categories.dart';
import 'package:fease/pages/reportbug.dart';
import 'package:fease/type/widget.dart';
import 'package:flutter/cupertino.dart';

class Settings extends WidgetWithTitle {
  const Settings({super.key}) : super(title: "Settings");

  @override
  State<Settings> createState() => _SettingsState();
}

class Item {
  final String label;
  final bool isDestructive;

  const Item(this.label, this.isDestructive);
}

const items = [
  Item("Categories", false),
  Item("Report a bug", false),
  Item("Erase All", true)
];

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        middle: Text("Settings"),
      ),
      child: SafeArea(
        left: true,
        top: true,
        right: true,
        bottom: true,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          transformAlignment: Alignment.center,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: const Color.fromARGB(225, 28, 28, 30),
                borderRadius: BorderRadius.circular(15)),
            child: CupertinoFormSection.insetGrouped(
              children: [
                ...List.generate(
                    items.length,
                    (index) => GestureDetector(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const Categories()));
                                break;
                              case 1:
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const ReportBug()));
                                break;
                              case 2:
                                break;
                            }
                          },
                          child: DecoratedBox(
                            decoration: const BoxDecoration(),
                            child: CupertinoFormRow(
                              prefix: Text(items[index].label,
                                  style: TextStyle(
                                      color: items[index].isDestructive
                                          ? const Color.fromARGB(
                                              255, 255, 69, 58)
                                          : const Color.fromARGB(
                                              255, 255, 255, 255))),
                              helper: null,
                              padding:
                                  const EdgeInsets.fromLTRB(16, 14, 16, 14),
                              child: items[index].isDestructive
                                  ? Container()
                                  : const Icon(CupertinoIcons.chevron_right),
                            ),
                          ),
                        ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
