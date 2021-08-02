import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:flutter/material.dart';

class StaffDetailView extends StatefulWidget {
  static const String STAFF_DETAIL_VIEW = '/manager/staffDetailView';
  const StaffDetailView({Key? key}) : super(key: key);

  @override
  _StaffDetailViewState createState() => _StaffDetailViewState();
}

class _StaffDetailViewState extends State<StaffDetailView> {
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: bgColor,
        iconTheme: IconThemeData(color: hintColor),
        title: Heading(title: 'Staff Details'),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(defaultPadding),
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                title: Text('Name'),
                trailing: Text(
                  'Customer Name 1',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
              ListTile(
                title: Text('Email'),
                trailing: Text(
                  'email1@gmail.com',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
              ListTile(
                title: Text('Temporary password'),
                trailing: Text(
                  'Yes',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 18,
                        color: Colors.green,
                      ),
                ),
              ),
              ListTile(
                title: Text('Admin approved'),
                trailing: Text(
                  'NO',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                ),
              ),
              ListTile(
                title: Text('Store'),
                trailing: Text(
                  'Store name',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
              ListTile(
                title: Text('Status'),
                trailing: Switch(
                    value: _isActive,
                    onChanged: (value) {
                      setState(
                        () {
                          _isActive = value;
                        },
                      );
                    }),
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }
}
