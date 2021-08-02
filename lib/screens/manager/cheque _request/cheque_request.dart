import 'package:fastcheque/screens/manager/cheque_details_manager_view/cheque_details_manager_view.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:flutter/material.dart';

class ChequeRequest extends StatefulWidget {
  const ChequeRequest({Key? key}) : super(key: key);

  @override
  _ChequeRequestState createState() => _ChequeRequestState();
}

class _ChequeRequestState extends State<ChequeRequest> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: ListTile(
              onTap: () => Navigator.of(context).pushNamed(
                  ChequeDetailsManagerView.CHEQUE_DETAILS_MANAGER_VIEW),
              title: Text('Customer name $index'),
              subtitle: Text('CHK0000$index'),
              trailing: Text('${index + 1}h ago'),
            ),
          );
        },
      ),
    );
  }
}
