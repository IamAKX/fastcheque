import 'package:fastcheque/utils/constants.dart';
import 'package:flutter/material.dart';

class ErrorInformation extends StatelessWidget {
  final List<String> hint;
  const ErrorInformation({
    Key? key,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(defaultPadding * 0.75),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attention',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.red,
                  fontSize: 18,
                ),
          ),
          SizedBox(
            height: defaultPadding / 2,
          ),
          for (String h in hint) ...{
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.red,
                  size: 18,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  h,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: Colors.red, fontSize: 14),
                ),
              ],
            ),
          }
        ],
      ),
    );
  }
}
