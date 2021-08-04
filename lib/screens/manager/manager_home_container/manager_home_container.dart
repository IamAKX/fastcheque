import 'package:fastcheque/screens/manager/cheque%20_request/cheque_request.dart';
import 'package:fastcheque/screens/manager/manager_profile/manager_profile.dart';
import 'package:fastcheque/screens/manager/staff_management/staff_management.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:flutter/material.dart';

class ManagerHomeContainer extends StatefulWidget {
  static const String MANAGER_HOME_CONTAINER_ROUTE = '/manager/home';
  const ManagerHomeContainer({Key? key}) : super(key: key);

  @override
  _ManagerHomeContainerState createState() => _ManagerHomeContainerState();
}

class _ManagerHomeContainerState extends State<ManagerHomeContainer> {
  List<BottomNavigationBarItem> bottomNavigation = [
    BottomNavigationBarItem(
        icon: Icon(Icons.text_snippet_outlined), label: 'Cheque'),
    BottomNavigationBarItem(icon: Icon(Icons.face_outlined), label: 'Staff'),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
  ];
  int _currentTabIndex = 0;

  List<String> title = [
    'Request',
    'Staff',
    'Profile',
  ];

  List<Widget> bodyWidgetList = [
    ChequeRequest(),
    StaffManagement(),
    ManagerProfile(),
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
