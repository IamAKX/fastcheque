import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcheque/main.dart';
import 'package:fastcheque/model/manager_model.dart';
import 'package:fastcheque/model/transaction_model.dart';
import 'package:fastcheque/screens/manager/manager_home_container/manager_home_container.dart';
import 'package:fastcheque/service/firestore_service.dart';
import 'package:fastcheque/service/snakbar_service.dart';
import 'package:fastcheque/service/storage_service.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/utils/preference_key.dart';
import 'package:fastcheque/widgets/custom_textfield.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ChequeDetailsManagerView extends StatefulWidget {
  static const String CHEQUE_DETAILS_MANAGER_VIEW =
      '/manager/chequeDetailManagerView';
  final Object transaction;
  const ChequeDetailsManagerView({Key? key, required this.transaction})
      : super(key: key);

  @override
  _ChequeDetailsManagerViewState createState() =>
      _ChequeDetailsManagerViewState();
}

class _ChequeDetailsManagerViewState extends State<ChequeDetailsManagerView> {
  TextEditingController _stockNumberController = TextEditingController();
  TextEditingController _customerNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _zipController = TextEditingController();
  TextEditingController _chequeAmountController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _requestDateController = TextEditingController();
  TextEditingController _rejectionReasonController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        builder: (BuildContext context, Widget? child) {
          return getDatePickerTheme(child);
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _requestDateController.text =
            DateFormat('MM/dd/yyyy ').format(selectedDate);
      });
  }

  int imageCount = 2;
  bool isEditingAllowed = false;
  List<String> chequeUrlList = [];

  late TransactionModel _transactionModel =
      widget.transaction as TransactionModel;
  late ManagerModel manager =
      ManagerModel.fromJson(prefs.getString(PreferenceKey.USER_DATA)!);

  @override
  void initState() {
    super.initState();
    _stockNumberController.text = _transactionModel.stockNumber;
    _customerNameController.text = _transactionModel.customerName;
    _addressController.text = _transactionModel.address;
    _cityController.text = _transactionModel.city;
    _stateController.text = _transactionModel.state;
    _zipController.text = _transactionModel.zipCode.toString();
    _chequeAmountController.text = _transactionModel.chequeAmount.toString();
    _phoneController.text = _transactionModel.phoneNumber;
    _emailController.text = _transactionModel.email;
    _requestDateController.text = _transactionModel.requestDate;
    selectedDate = _transactionModel.createAt;
    chequeUrlList = _transactionModel.photos;
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: bgColor,
        iconTheme: IconThemeData(color: hintColor),
        title: Heading(title: 'Details'),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(defaultPadding),
          children: [
            CustomTextField(
              textCtrl: _stockNumberController,
              iconData: Icons.pin_rounded,
              hint: 'Stock Number',
              enabled: isEditingAllowed,
            ),
            CustomTextField(
              textCtrl: _customerNameController,
              iconData: Icons.person,
              hint: 'Customer Name',
              enabled: isEditingAllowed,
            ),
            CustomTextField(
              textCtrl: _addressController,
              iconData: Icons.maps_home_work,
              hint: 'Address',
              enabled: isEditingAllowed,
            ),
            CustomTextField(
              textCtrl: _cityController,
              iconData: Icons.location_city,
              hint: 'City',
              enabled: isEditingAllowed,
            ),
            CustomTextField(
              textCtrl: _stateController,
              iconData: Icons.location_history,
              hint: 'State',
              enabled: isEditingAllowed,
            ),
            CustomTextField(
              textCtrl: _zipController,
              iconData: Icons.pin_drop,
              hint: 'Zip',
              enabled: isEditingAllowed,
            ),
            // DatePickerTextField(
            //   textCtrl: _requestDateController,
            //   iconData: Icons.calendar_today,
            //   hint: 'Request Date',
            //   onTapFunction: _selectDate(context),
            // ),
            Padding(
              padding: const EdgeInsets.only(bottom: defaultPadding),
              child: TextField(
                enabled: isEditingAllowed,
                onTap: () {
                  _selectDate(context);
                },
                autocorrect: true,
                controller: _requestDateController,
                decoration: InputDecoration(
                  hintText: 'Request Date',
                  labelText: 'Request Date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
            ),
            CustomTextField(
              enabled: isEditingAllowed,
              textCtrl: _chequeAmountController,
              iconData: Icons.attach_money,
              hint: 'Cheque Amount',
            ),
            CustomTextField(
              enabled: isEditingAllowed,
              textCtrl: _phoneController,
              iconData: Icons.phone,
              hint: 'Phone',
            ),
            CustomTextField(
              enabled: isEditingAllowed,
              textCtrl: _emailController,
              iconData: Icons.email,
              hint: 'Email',
            ),
            Text('Add Cheque Image'),
            Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                ),
                borderRadius: BorderRadius.circular(2),
                color: fillColor,
              ),
              child: Wrap(
                spacing: defaultPadding / 2,
                runSpacing: defaultPadding,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.spaceBetween,
                children: [
                  if (isEditingAllowed)
                    Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: () async {
                          if (chequeUrlList.length == 3) {
                            SnackBarService.instance.showSnackBarError(
                                'You can upload at max 3 images');
                            return;
                          }
                          var permission =
                              await Permission.storage.request().isGranted;
                          if (permission) {
                            final ImagePicker _picker = ImagePicker();
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery);

                            if (image != null) {
                              File file = File(image.path);
                              String url = await StorageService.instance
                                  .uploadCheque(file, context);
                              if (url.length > 0) {
                                setState(() {
                                  chequeUrlList.add(url);
                                });
                              }
                            } else {
                              // User canceled the picker
                              SnackBarService.instance.showSnackBarError(
                                  'No file has been uploaded');
                            }
                          } else {
                            SnackBarService.instance
                                .showSnackBarError('Storage access denied');
                          }
                        },
                        icon: Icon(
                          Icons.add,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  for (var i = 0; i < chequeUrlList.length; i++) ...{
                    Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                chequeUrlList.elementAt(i),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 2,
                          top: 2,
                          child: InkWell(
                            onTap: isEditingAllowed
                                ? () {
                                    setState(() {
                                      chequeUrlList.removeAt(i);
                                    });
                                  }
                                : null,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  }
                ],
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => showRejectionReasonPopup(context),
                    child: Text('Reject'),
                  ),
                ),
                SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      _transactionModel.rejectionReason = '';
                      _transactionModel.status = TransactionStatus.APPROVED;
                      _transactionModel.approverDetail = manager;
                      _transactionModel.lastUpdated = Timestamp.now();
                      await FireStoreService.instance
                          .updateTransaction(_transactionModel)
                          .then((value) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(
                      'Accept',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  showRejectionReasonPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rejection feedback',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close),
                  )
                ],
              ),
              SizedBox(
                height: defaultPadding,
              ),
              TextField(
                controller: _rejectionReasonController,
                maxLines: 10,
              ),
              SizedBox(
                height: defaultPadding,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    if (_rejectionReasonController.text.isEmpty) {
                      SnackBarService.instance
                          .showSnackBarError('Enter rejection reason');
                      Navigator.of(context).pop();
                      return;
                    }

                    _transactionModel.rejectionReason =
                        _rejectionReasonController.text;
                    _transactionModel.status = TransactionStatus.REJECTED;
                    _transactionModel.asignedTo = _transactionModel.initiatorID;
                    _transactionModel.lastUpdated = Timestamp.now();
                    await FireStoreService.instance
                        .updateTransaction(_transactionModel)
                        .then((value) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text(
                    'Reject',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
