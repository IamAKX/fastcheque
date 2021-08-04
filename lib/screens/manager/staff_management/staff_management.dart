import 'package:fastcheque/model/staff_model.dart';
import 'package:fastcheque/screens/manager/staff_detail_view/staff_detail_view.dart';
import 'package:fastcheque/service/firestore_service.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StaffManagement extends StatefulWidget {
  const StaffManagement({Key? key}) : super(key: key);

  @override
  _StaffManagementState createState() => _StaffManagementState();
}

class _StaffManagementState extends State<StaffManagement> {
  List<StaffModel> _allStaff = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAllStaff();
  }

  loadAllStaff() async {
    _allStaff = await FireStoreService.instance.readAllStaff();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _allStaff.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _allStaff.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: ListTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed(StaffDetailView.STAFF_DETAIL_VIEW,
                            arguments: _allStaff.elementAt(index))
                        .then((value) => loadAllStaff()),
                    title: Text('${_allStaff.elementAt(index).name}'),
                    subtitle: Text('${_allStaff.elementAt(index).email}'),
                    trailing: _allStaff.elementAt(index).hasManagerApproved
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
