import 'package:fastcheque/model/staff_model.dart';
import 'package:fastcheque/service/firestore_service.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:flutter/material.dart';

class StaffDetailView extends StatefulWidget {
  static const String STAFF_DETAIL_VIEW = '/manager/staffDetailView';
  final Object staff;
  const StaffDetailView({Key? key, required this.staff}) : super(key: key);

  @override
  _StaffDetailViewState createState() => _StaffDetailViewState();
}

class _StaffDetailViewState extends State<StaffDetailView> {
  late StaffModel _staffModel = widget.staff as StaffModel;
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
                  '${_staffModel.name}',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
              ListTile(
                title: Text('Email'),
                trailing: Text(
                  '${_staffModel.email}',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
              ListTile(
                title: Text('Temporary password'),
                trailing: Text(
                  _staffModel.isPasswordTemporary ? 'YES' : 'NO',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
              ListTile(
                title: Text('Admin approved'),
                trailing: Text(
                  _staffModel.isProfileActive ? 'YES' : 'NO',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
              ListTile(
                title: Text('Store'),
                trailing: Text(
                  '${_staffModel.taggedStore.businessName}',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
              ListTile(
                title: Text('Status'),
                trailing: Switch(
                    value: _staffModel.hasManagerApproved,
                    onChanged: (value) {
                      setState(
                        () {
                          _staffModel.hasManagerApproved = value;
                          FireStoreService.instance
                              .toggleManagerApprovedStatus(_staffModel);
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
