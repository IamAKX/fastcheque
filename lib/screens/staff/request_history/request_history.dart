import 'dart:math';

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
    return ListView(
      padding: EdgeInsets.all(defaultPadding),
      children: [
        for (var i = 0; i < 50; i++) ...{
          ListTile(
            leading: getTileIcon(),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer Name $i'),
                Text(
                  'CHK0000000$i',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: hintColor),
                ),
              ],
            ),
            subtitle: getStatusText(),
            isThreeLine: true,
            trailing: Text('1d ago'),
          )
        }
      ],
    );
  }

  Icon getTileIcon() {
    var rng = new Random();
    int id = rng.nextInt(4);
    switch (id) {
      case 0:
      case 1:
        return Icon(Icons.check, color: Colors.green);
      case 2:
        return Icon(
          Icons.close_sharp,
          color: Colors.red,
        );
      default:
        return Icon(
          Icons.history,
          color: Colors.amber,
        );
    }
  }

  Text getStatusText() {
    var rng = new Random();
    int id = rng.nextInt(4);
    switch (id) {
      case 0:
      case 1:
        return Text(
          'Submitted',
          style: TextStyle(color: Colors.amber),
        );
      case 2:
        return Text(
          'Approved',
          style: TextStyle(color: Colors.green),
        );
      default:
        return Text(
          'Rejected',
          style: TextStyle(color: Colors.red),
        );
    }
  }
}
