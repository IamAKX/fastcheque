import 'package:fastcheque/utils/constants.dart';
import 'package:flutter/material.dart';

class StaffManagement extends StatefulWidget {
  const StaffManagement({Key? key}) : super(key: key);

  @override
  _StaffManagementState createState() => _StaffManagementState();
}

class _StaffManagementState extends State<StaffManagement> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: ListTile(
              title: Text('Staff Name $index'),
              subtitle: Text('email$index@gmail.com'),
              trailing: (index % 2 == 0)
                  ? Text(
                      'Active',
                      style: TextStyle(color: Colors.green),
                    )
                  : Text(
                      'Suspended',
                      style: TextStyle(color: Colors.red),
                    ),
            ),
          );
        },
      ),
    );
  }
}
