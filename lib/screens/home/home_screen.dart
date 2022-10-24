import 'package:flutter/material.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/tabs/home_tab.dart';
import 'package:devfestbolivia/tabs/profile_tab.dart';
import 'package:devfestbolivia/tabs/scanner_tab.dart';
import 'package:devfestbolivia/tabs/contests_tab.dart';
import 'package:devfestbolivia/tabs/timeline_tab.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    TimelineTab(),
    ScannerTab(),
    ContestsTab(),
    ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: DevFestColors.primary,
            icon: Icon(Icons.home_outlined),
            label: TextStrings.home,
          ),
          BottomNavigationBarItem(
            backgroundColor: DevFestColors.primary,
            icon: Icon(MdiIcons.calendarMonthOutline),
            label: TextStrings.timeline,
          ),
          BottomNavigationBarItem(
            backgroundColor: DevFestColors.primary,
            icon: Icon(Icons.qr_code),
            label: TextStrings.scanner,
          ),
          BottomNavigationBarItem(
            backgroundColor: DevFestColors.primary,
            icon: Icon(MdiIcons.trophyVariantOutline),
            label: TextStrings.contests,
          ),
          BottomNavigationBarItem(
            backgroundColor: DevFestColors.primary,
            icon: Icon(Icons.account_circle_outlined),
            label: TextStrings.profile,
          ),
        ],
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        // selectedFontSize: FontSizeValues.barItem,
        selectedItemColor: DevFestColors.primaryLight,
        unselectedItemColor: DevFestColors.primaryLight,
      ),
    );
  }
}
