import 'dart:math';

import 'package:fastcheque/screens/staff/cheque_details_staff_view/cheque_details_staff_view.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:flutter/material.dart';

class RequestHistory extends StatefulWidget {
  const RequestHistory({Key? key}) : super(key: key);

  @override
  _RequestHistoryState createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(defaultPadding),
      itemBuilder: (context, index) {
        int rand = Random().nextInt(3);
        return ListTile(
          onTap: () => Navigator.of(context)
              .pushNamed(ChequeDetailsStaffView.CHEQUE_DETAILS_STAFF_VIEW),
          leading: statusIcon.elementAt(rand),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer Name $index'),
              Text(
                'CHK0000000$index',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: hintColor),
              ),
            ],
          ),
          subtitle: statusText.elementAt(rand),
          isThreeLine: true,
          trailing: Text('${index + 1}d ago'),
        );
      },
    );
  }

  List<Text> statusText = [
    Text(
      'Submitted',
      style: TextStyle(color: Colors.amber),
    ),
    Text(
      'Approved',
      style: TextStyle(color: Colors.green),
    ),
    Text(
      'Rejected',
      style: TextStyle(color: Colors.red),
    )
  ];

  List<Icon> statusIcon = [
    Icon(
      Icons.history,
      color: Colors.amber,
    ),
    Icon(
      Icons.check,
      color: Colors.green,
    ),
    Icon(
      Icons.close_sharp,
      color: Colors.red,
    )
  ];
}
