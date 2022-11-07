import 'package:devfestbolivia/firebase/schedule/schedule_repository_impl.dart';
import 'package:devfestbolivia/firebase/schedule/schedules_firestore.dart';
import 'package:devfestbolivia/providers/schedules_provider.dart';
import 'package:flutter/material.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/tabs/home_tab.dart';
import 'package:devfestbolivia/tabs/profile_tab.dart';
import 'package:devfestbolivia/tabs/scanner_tab.dart';
import 'package:devfestbolivia/tabs/contests_tab.dart';
import 'package:devfestbolivia/tabs/timeline_tab.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

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
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<SchedulesProvider>(
            create: (_) => SchedulesProvider(
              scheduleRepository: ScheduleRepositoryImpl(
                schedulesFirestore: SchedulesFirestore(),
              ),
            ),
          )
        ],
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
        backgroundColor: DevFestColors.primary,
        // selectedFontSize: FontSizeValues.barItem,
        selectedItemColor: DevFestColors.primaryLight,
        unselectedItemColor: DevFestColors.primaryLight,
      ),
    );
  }
}
