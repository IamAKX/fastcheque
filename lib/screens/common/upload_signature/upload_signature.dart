import 'package:fastcheque/utils/color.dart';
import 'package:fastcheque/utils/constants.dart';
import 'package:fastcheque/widgets/heading.dart';
import 'package:flutter/material.dart';

class UploadSignature extends StatefulWidget {
  static const String UPLOAD_SIGNATURE_ROUTE = '/uploadSignature';
  const UploadSignature({Key? key}) : super(key: key);

  @override
  _UploadSignatureState createState() => _UploadSignatureState();
}

class _UploadSignatureState extends State<UploadSignature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: bgColor,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: hintColor.withOpacity(0.5),
        ),
        title: Heading(
          title: 'Signature',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 230,
                    width: double.infinity,
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 30,
                    child: Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.add_photo_alternate,
                        color: bgColor,
                      ),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: bgColor, width: 5),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => null,
                  child: Text('Upload'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
