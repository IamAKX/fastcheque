import 'package:fastcheque/model/store_model.dart';
import 'package:fastcheque/model/transaction_model.dart';
import 'package:fastcheque/screens/manager/cheque_details_manager_view/cheque_details_manager_view.dart';
import 'package:fastcheque/service/firestore_service.dart';
import 'package:fastcheque/service/snakbar_service.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/utils/preference_key.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../main.dart';

class ChequeRequest extends StatefulWidget {
  const ChequeRequest({Key? key}) : super(key: key);

  @override
  _ChequeRequestState createState() => _ChequeRequestState();
}

class _ChequeRequestState extends State<ChequeRequest> {
  List<TransactionModel> _transactionList = [];
  late StoreModel store =
      StoreModel.fromJson(prefs.getString(PreferenceKey.CURRENT_STORE)!);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAllTransaction();
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    return SafeArea(
      child: _transactionList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _transactionList.length,
              itemBuilder: (BuildContext context, int index) {
                TransactionModel transactionModel =
                    _transactionList.elementAt(index);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: ListTile(
                    onTap: () => Navigator.of(context).pushNamed(
                        ChequeDetailsManagerView.CHEQUE_DETAILS_MANAGER_VIEW),
                    title: Text('${transactionModel.customerName}'),
                    subtitle: Text('${transactionModel.chequeID}'),
                    trailing: Text(
                        '${timeago.format(transactionModel.lastUpdated.toDate(), locale: 'en_short')} ago'),
                  ),
                );
              },
            ),
    );
  }

  Future<void> loadAllTransaction() async {
    _transactionList =
        await FireStoreService.instance.readTransactionByStoreID(store.id);
    setState(() {});
  }
}
