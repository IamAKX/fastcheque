import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

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
  bool _agreement = false;

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
          iconData: Icons.pin_rounded,
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
        CustomTextField(
          textCtrl: _chequeAmountController,
          iconData: Icons.calendar_today,
          hint: 'Request Date',
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
