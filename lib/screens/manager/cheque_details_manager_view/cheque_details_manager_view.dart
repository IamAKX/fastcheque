import 'package:fastcheque/screens/manager/manager_home_container/manager_home_container.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/widgets/custom_textfield.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChequeDetailsManagerView extends StatefulWidget {
  static const String CHEQUE_DETAILS_MANAGER_VIEW =
      '/manager/chequeDetailManagerView';

  const ChequeDetailsManagerView({Key? key}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    _stockNumberController.text = "ABCD1234";
    _customerNameController.text = 'Customer name';
    _addressController.text = '123/A, Bla Bla Road';
    _cityController.text = 'Kolkata';
    _stateController.text = 'West Bengal';
    _zipController.text = '700001';
    _chequeAmountController.text = '10000';
    _phoneController.text = '9804945122';
    _emailController.text = 'akx.sonu@gmail.com';
    _requestDateController.text = '08/01/2021';
  }

  @override
  Widget build(BuildContext context) {
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
                  Container(
                    width: 80,
                    height: 80,
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () {
                        if (imageCount < 3)
                          setState(() {
                            imageCount++;
                          });
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
                  for (var i = 0; i < imageCount; i++) ...{
                    Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryColor,
                          ),
                        ),
                        Positioned(
                          right: 2,
                          top: 2,
                          child: InkWell(
                            onTap: () {
                              if (imageCount > 0) {
                                setState(() {
                                  imageCount--;
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
                    onPressed: () => Navigator.of(context).pop(),
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
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(
                          ManagerHomeContainer.MANAGER_HOME_CONTAINER_ROUTE,
                          (route) => false),
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
