import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastcheque/main.dart';
import 'package:fastcheque/model/manager_model.dart';
import 'package:fastcheque/model/staff_model.dart';
import 'package:fastcheque/model/store_model.dart';
import 'package:fastcheque/model/transaction_model.dart';
import 'package:fastcheque/service/firestore_service.dart';
import 'package:fastcheque/service/snakbar_service.dart';
import 'package:fastcheque/service/storage_service.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/utils/preference_key.dart';
import 'package:fastcheque/utils/validation.dart';
import 'package:fastcheque/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CreateCheque extends StatefulWidget {
  const CreateCheque({Key? key}) : super(key: key);

  @override
  _CreateChequeState createState() => _CreateChequeState();
}

class _CreateChequeState extends State<CreateCheque> {
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
  bool _agreement = false;
  List<String> chequeUrlList = [];
  DateTime selectedDate = DateTime.now();

  late FireStoreService _fireStoreService;

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

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _fireStoreService = Provider.of<FireStoreService>(context);
    return ListView(
      padding: EdgeInsets.all(defaultPadding),
      children: [
        CustomTextField(
          textCtrl: _stockNumberController,
          iconData: Icons.pin_rounded,
          hint: 'Stock Number',
        ),
        CustomTextField(
          textCtrl: _customerNameController,
          iconData: Icons.person,
          hint: 'Customer Name',
        ),
        CustomTextField(
          textCtrl: _addressController,
          iconData: Icons.maps_home_work,
          hint: 'Address',
        ),
        CustomTextField(
          textCtrl: _cityController,
          iconData: Icons.location_city,
          hint: 'City',
        ),
        CustomTextField(
          textCtrl: _stateController,
          iconData: Icons.location_history,
          hint: 'State',
        ),
        CustomTextField(
          textCtrl: _zipController,
          iconData: Icons.pin_drop,
          hint: 'Zip',
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: defaultPadding),
          child: TextField(
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
          textCtrl: _chequeAmountController,
          iconData: Icons.attach_money,
          hint: 'Cheque Amount',
        ),
        CustomTextField(
          textCtrl: _phoneController,
          iconData: Icons.phone,
          hint: 'Phone',
        ),
        CustomTextField(
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
              Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () async {
                    if (chequeUrlList.length == 3) {
                      SnackBarService.instance
                          .showSnackBarError('You can upload at max 3 images');
                      return;
                    }
                    var permission =
                        await Permission.storage.request().isGranted;
                    if (permission) {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);

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
                        SnackBarService.instance
                            .showSnackBarError('No file has been uploaded');
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
                        onTap: () {
                          if (chequeUrlList.isNotEmpty) {
                            setState(() {
                              chequeUrlList.removeAt(i);
                            });
                          }
                        },
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
        CheckboxListTile(
          title: Text(
            'I have verified all the details filled above',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          value: _agreement,
          contentPadding: EdgeInsets.all(0),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (value) {
            setState(() {
              _agreement = value!;
            });
          },
        ),
        SizedBox(
          height: defaultPadding,
        ),
        TextButton(
          onPressed: _fireStoreService.status ==
                  DatabaseTransactionStatus.QUERYING
              ? null
              : () async {
                  if (validateInputs()) {
                    StoreModel store = StoreModel.fromJson(
                        prefs.getString(PreferenceKey.CURRENT_STORE)!);
                    StaffModel staff = StaffModel.fromJson(
                        prefs.getString(PreferenceKey.USER_DATA)!);
                    int count = await FireStoreService.instance
                        .getChequeCountStartingWith(store.chequeSequenceNumber);
                    TransactionModel transactionModel = new TransactionModel(
                        stockNumber: _stockNumberController.text,
                        customerName: _customerNameController.text,
                        address: _addressController.text,
                        city: _cityController.text,
                        state: _stateController.text,
                        zipCode: int.parse(_zipController.text),
                        requestDate: _requestDateController.text,
                        chequeAmount:
                            double.parse(_chequeAmountController.text),
                        phoneNumber: _phoneController.text,
                        email: _emailController.text,
                        photos: chequeUrlList,
                        chequeID:
                            '${store.chequeSequenceNumber}00000${count + 1}',
                        id: '',
                        createAt: selectedDate,
                        initiatorID: staff.id,
                        asignedTo: store.id,
                        approvedBy: '',
                        storeDetail: store,
                        initiatorDetail: staff,
                        status: TransactionStatus.SUBMITTED,
                        chequeSequence: store.chequeSequenceNumber,
                        rejectionReason: '',
                        lastUpdated: Timestamp.now());
                    bool createStatus = await _fireStoreService
                        .createTransaction(transactionModel);

                    print('createStatus = $createStatus');
                    if (!createStatus) {
                      setState(() {
                        _stockNumberController.text = '';
                        _customerNameController.text = '';
                        _addressController.text = '';
                        _cityController.text = '';
                        _stateController.text = '';
                        _zipController.text = '';
                        _chequeAmountController.text = '';
                        _phoneController.text = '';
                        _emailController.text = '';
                        _requestDateController.text = '';
                        _agreement = false;
                        chequeUrlList = [];
                        selectedDate = DateTime.now();
                      });
                    }
                  }
                },
          child: Text(
            _fireStoreService.status == DatabaseTransactionStatus.QUERYING
                ? 'Please wait...'
                : 'Generate Cheque',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  bool validateInputs() {
    if (_stockNumberController.text.isEmpty) {
      SnackBarService.instance
          .showSnackBarError('Stock number cannot be empty');
      return false;
    }
    if (_customerNameController.text.isEmpty) {
      SnackBarService.instance
          .showSnackBarError('Customer name cannot be empty');
      return false;
    }
    if (_addressController.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Address cannot be empty');
      return false;
    }
    if (_cityController.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('City cannot be empty');
      return false;
    }
    if (_stateController.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('State cannot be empty');
      return false;
    }
    if (_zipController.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Zip code cannot be empty');
      return false;
    }
    if (!isNumeric(_zipController.text)) {
      SnackBarService.instance.showSnackBarError('Invalid zip code');
      return false;
    }

    if (_requestDateController.text.isEmpty) {
      SnackBarService.instance
          .showSnackBarError('Requested date cannot be empty');
      return false;
    }
    if (_chequeAmountController.text.isEmpty) {
      SnackBarService.instance
          .showSnackBarError('Cheque amount cannot be empty');
      return false;
    }
    if (!isNumeric(_stockNumberController.text)) {
      SnackBarService.instance.showSnackBarError('Invalid cheque amount');
      return false;
    }
    if (_phoneController.text.isEmpty) {
      SnackBarService.instance
          .showSnackBarError('Phone number cannot be empty');
      return false;
    }
    if (!isNumeric(_phoneController.text)) {
      SnackBarService.instance.showSnackBarError('Invalid phone number');
      return false;
    }

    if (_emailController.text.isEmpty) {
      SnackBarService.instance.showSnackBarError('Email cannot be empty');
      return false;
    }
    if (!checkValidEmail(_emailController.text)) {
      return false;
    }

    if (chequeUrlList.isEmpty) {
      SnackBarService.instance
          .showSnackBarError('Upload atleast one cheque image');
      return false;
    }

    if (!_agreement) {
      SnackBarService.instance
          .showSnackBarError('Check the agreement statement');
      return false;
    }
    return true;
  }
}
