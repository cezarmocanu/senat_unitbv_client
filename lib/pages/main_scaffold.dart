import 'package:flutter/material.dart';
import 'package:senat_unit_bv/pages/tabs/history_tab.dart';
import 'package:senat_unit_bv/pages/tabs/meetings_tab.dart';
import 'package:senat_unit_bv/pages/tabs/more_tab.dart';

class MainScaffoldPage extends StatefulWidget {
  const MainScaffoldPage({Key? key}) : super(key: key);

  @override
  State<MainScaffoldPage> createState() => _MainScaffoldPageState();
}

class _MainScaffoldPageState extends State<MainScaffoldPage> {
  late PageController pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageController,
          children: [
            MeetingsTab(),
            HistoryTab(),
            MoreTab(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              label: 'Sedinte',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Istoric',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'Mai multe',
            ),
          ],
          currentIndex: _currentIndex,
          showUnselectedLabels: true,
          onTap: (index) => setState(() {
            _currentIndex = index;
            pageController.jumpToPage(index);
          }),
        ),
      ),
    );
  }
}
