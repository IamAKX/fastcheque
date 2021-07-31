import 'package:fastcheque/screens/staff/create_cheque/create_cheque.dart';
import 'package:fastcheque/screens/staff/request_history/request_history.dart';
import 'package:fastcheque/screens/staff/staff_profile/staff_profile.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:flutter/material.dart';

class StaffHomeContainer extends StatefulWidget {
  static const String STAFF_HOME_CONTAINER_ROUTE = '/staff/home';
  const StaffHomeContainer({Key? key}) : super(key: key);

  @override
  _StaffHomeContainerState createState() => _StaffHomeContainerState();
}

class _StaffHomeContainerState extends State<StaffHomeContainer> {
  List<BottomNavigationBarItem> bottomNavigation = [
    BottomNavigationBarItem(
        icon: Icon(Icons.text_snippet_outlined), label: 'Cheque'),
    BottomNavigationBarItem(icon: Icon(Icons.list_outlined), label: 'Requests'),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
  ];
  int _currentTabIndex = 0;

  List<String> title = [
    'Create',
    'History',
    'Profile',
  ];

  List<Widget> bodyWidgetList = [
    CreateCheque(),
    RequestHistory(),
    StaffProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: bgColor,
        centerTitle: false,
        actions: [
          PopupMenuButton(
            offset: Offset(10, 50),
            onSelected: (value) {
              switch (value) {
                case 0:
                  print('All requet');
                  break;
                case 1:
                  print('Contact us');
                  break;
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: hintColor,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text('All Request'),
              ),
              PopupMenuItem(
                value: 1,
                child: Text('Contact Us'),
              ),
            ],
          )
        ],
        title: Heading(
          title: title.elementAt(_currentTabIndex),
        ),
      ),
      body: bodyWidgetList.elementAt(_currentTabIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavigation,
        currentIndex: _currentTabIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (value) {
          setState(() {
            _currentTabIndex = value;
          });
        },
      ),
    );
  }
}
