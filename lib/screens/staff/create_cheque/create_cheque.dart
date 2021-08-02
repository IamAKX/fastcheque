import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/widgets/custom_textfield.dart';
import 'package:fastcheque/widgets/datepicker_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  int imageCount = 0;

  @override
  Widget build(BuildContext context) {
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
        // DatePickerTextField(
        //   textCtrl: _requestDateController,
        //   iconData: Icons.calendar_today,
        //   hint: 'Request Date',
        //   onTapFunction: _selectDate(context),
        // ),
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
          onPressed: () {},
          child: Text(
            'Generate Cheque',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
