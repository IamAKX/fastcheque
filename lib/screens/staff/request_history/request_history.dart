import 'package:fastcheque/main.dart';
import 'package:fastcheque/model/staff_model.dart';
import 'package:fastcheque/model/transaction_model.dart';
import 'package:fastcheque/screens/staff/cheque_details_staff_view/cheque_details_staff_view.dart';
import 'package:fastcheque/service/firestore_service.dart';
import 'package:fastcheque/service/snakbar_service.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/utils/preference_key.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class RequestHistory extends StatefulWidget {
  const RequestHistory({Key? key}) : super(key: key);

  @override
  _RequestHistoryState createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  List<TransactionModel> _transactionList = [];
  late StaffModel staff =
      StaffModel.fromJson(prefs.getString(PreferenceKey.USER_DATA)!);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAllTransaction();
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    return _transactionList.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _transactionList.length,
            padding: EdgeInsets.all(defaultPadding),
            itemBuilder: (context, index) {
              TransactionModel transaction = _transactionList.elementAt(index);
              return ListTile(
                onTap: () => Navigator.of(context).pushNamed(
                    ChequeDetailsStaffView.CHEQUE_DETAILS_STAFF_VIEW),
                leading:
                    statusIcon.elementAt(getIndexByStatus(transaction.status)),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${transaction.customerName}'),
                    Text(
                      '${transaction.chequeID}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: hintColor),
                    ),
                  ],
                ),
                subtitle:
                    statusText.elementAt(getIndexByStatus(transaction.status)),
                isThreeLine: true,
                trailing: Text(timeago.format(transaction.lastUpdated.toDate(),
                    locale: 'en_short')),
              );
            },
          );
  }

  getIndexByStatus(String status) {
    if (status == TransactionStatus.SUBMITTED) return 0;
    if (status == TransactionStatus.APPROVED) return 1;
    if (status == TransactionStatus.REJECTED) return 2;
  }

  List<Text> statusText = [
    Text(
      TransactionStatus.SUBMITTED,
      style: TextStyle(color: Colors.amber),
    ),
    Text(
      TransactionStatus.APPROVED,
      style: TextStyle(color: Colors.green),
    ),
    Text(
      TransactionStatus.REJECTED,
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

  void loadAllTransaction() async {
    _transactionList =
        await FireStoreService.instance.readTransactionByStaffID(staff.id);
    setState(() {});
  }
}
