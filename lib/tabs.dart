import 'package:fease/pages/add.dart';
import 'package:fease/pages/expense.dart';
import 'package:fease/pages/report.dart';
import 'package:fease/pages/settings.dart';
import 'package:fease/type/widget.dart';
import 'package:flutter/cupertino.dart';

class TabsController extends StatefulWidget {
  const TabsController({super.key});

  @override
  State<TabsController> createState() => _TabsControllerState();
}

class _TabsControllerState extends State<TabsController> {
  var _selectedIndex = 0;

  static final Set<WidgetWithTitle> _pages = {
    const Expense(),
    const Report(),
    const ExpenseAdd(),
    const Settings()
  };

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.tray_arrow_up),
              label: 'Expense',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chart_bar_alt_fill),
              label: 'Report',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.add),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.gear_solid),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return _pages.elementAt(index);
            },
          );
        });
  }
}
